Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVEQNE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVEQNE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 09:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVEQNE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 09:04:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28886 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261439AbVEQNE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 09:04:57 -0400
Subject: Re: [PATCH] Fix root hole in raw device
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Greg K-H <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050517045748.GO1150@parcelfarce.linux.theplanet.co.uk>
References: <11163046682662@kroah.com> <11163046681444@kroah.com>
	 <20050517045748.GO1150@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116335082.1963.58.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 17 May 2005 14:04:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2005-05-17 at 05:57, Al Viro wrote:

> That is not quite correct.  You are passing very odd filp to ->ioctl()...
> Old variant gave NULL, which is also not too nice, though.

Which would you prefer?  I guess that if there _are_ going to be
problems, we'd be better off finding them early by passing in the NULL
value.

--Stephen

