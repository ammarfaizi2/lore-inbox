Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVKJMp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVKJMp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVKJMp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:45:26 -0500
Received: from mx1.suse.de ([195.135.220.2]:14275 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750701AbVKJMp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:45:26 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH] x86-64: remove unprotected iret
Date: Thu, 10 Nov 2005 04:38:06 +0100
User-Agent: KMail/1.8
Cc: "Jan Beulich" <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <4370AFF0.76F0.0078.0@novell.com> <4370C333.76F0.0078.0@novell.com>
In-Reply-To: <4370C333.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200511100438.06555.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 November 2005 15:24, Jan Beulich wrote:
> Make sure no iret can fault without attached recovery code.

The reason it was done this way was that normally iret can only go
bad after ptrace and ptrace is handled in the careful path.

But I agree it's safer.

Your patch series looks good. I will try to merge it later

-Andi
