Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965299AbWJ2RCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965299AbWJ2RCc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 12:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965303AbWJ2RCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 12:02:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:8050 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965299AbWJ2RCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 12:02:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Fxz42NeShHvmWVVDjMmHlnxRgkK7+Q9rr7y5e8t+TtprrOmlEshH22TkJruk9CYtK07InXMHjTjx24wi5vCELQxWecw3dzqxipBQ7sKzKxJ+vx+8JSWhVqr1CbdZRj+hUarRdMlvYaoCdfgsZqE9Qek4PoSaMElB1B72wHgiLuk=
Date: Sun, 29 Oct 2006 18:02:26 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "signed" versus "__signed__" versus "__signed" in arch-specific  "types.h" files
Message-ID: <20061029170226.GA29903@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610290537290.6187@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day <rpjday@mindspring.com> ha scritto:
>  so the keyword alias "__signed__" is used early on in nearly every
> types.h file but, if __KERNEL__ is defined, the file falls back to
> just using "signed".  (the use of "unsigned" is, of course, consistent
> throughout.)

When __KERNEL__ is not defined then that part of the header may be
exposed to userspace[1]. Older compilers (or newer versions of gcc with
-traditional used to compile old programs) don't recognize the keyword
'signed', hence the alternate keyword is used.
Extreme backward compatibility I'd say ;) I doubt that today is
possibile to compile anything with -traditional on a distro recent
enough to use kernel 2.6.

Luca
[1] You'd better use the cleaned up version of the headers though.
-- 
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925
