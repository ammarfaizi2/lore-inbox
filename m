Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbVJGMpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbVJGMpw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 08:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVJGMpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 08:45:52 -0400
Received: from quark.didntduck.org ([69.55.226.66]:43986 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932508AbVJGMpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 08:45:52 -0400
Message-ID: <43466E2E.7030403@didntduck.org>
Date: Fri, 07 Oct 2005 08:46:38 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.4 (X11/20050928)
MIME-Version: 1.0
To: sampersy@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: What does that "%U0" and "%X0" mean
References: <007701c5cb37$da03d050$c901a8c0@sp>
In-Reply-To: <007701c5cb37$da03d050$c901a8c0@sp>
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sampersy@gmail.com wrote:
> What does that "%U0" and "%X0" mean in 
> __asm__ __volatile__("stb%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));
> 
> does any reference existing ?

The X and U prefixes are arch specific.  This looks like ppc code.  The
only references I've every found are the gcc source code.  The gcc
source says:

U: Print 'u' if this has an auto-increment or auto-decrement.
X: Print 'x' if this is an indexed address.

--
				Brian Gerst
