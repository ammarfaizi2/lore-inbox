Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268022AbUHFOKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268022AbUHFOKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268017AbUHFOKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:10:25 -0400
Received: from mailfe06.swip.net ([212.247.154.161]:24502 "EHLO
	mailfe06.swip.net") by vger.kernel.org with ESMTP id S268022AbUHFOKN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:10:13 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Fri, 6 Aug 2004 16:10:07 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Mario Lang <mlang@delysid.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/vcs: stuck with dimensions <255?
Message-ID: <20040806141007.GF3663@bouh.is-a-geek.org>
Mail-Followup-To: Mario Lang <mlang@delysid.org>,
	linux-kernel@vger.kernel.org
References: <BoGf.1UP.11@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BoGf.1UP.11@gated-at.bofh.it>
User-Agent: Mutt/1.4.1i-nntp3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 30 sep 2003 à 11:10:11 +0200, Mario Lang a tapoté sur son clavier :
> I just realized, that /dev/vcsa behaviour is broken when
> used with lines or columns more than 255.  I can easily
> get this behaviour by using the built-in 4x6 font on a
> 1024xsomething resolution.  That results in 256 columns.  However,
> the vcs devices expose dimensions and cursor position in the first
> 4 bytes.
> 
> My question is now:  Are we stuck with this now?  I found that
> it is at least possible to use TIOCGWINSZ on the corresponding
> /dev/tty%d device to get correct dimensions, but then again, how
> would I optain the cursor position?
> 
> I am wondering why a char was choosen at all.  I see no gain
> by "saving" space there...

Well, vcsa was added a long time ago, I guess such dimensions weren't
possible at that time.

Of course we aren't stuck: we just need to add /dev/vcsx* which would
hold 32-bits integers, hoping this is sufficient once for all...

Regards,
Samuel
