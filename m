Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbVJEUFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbVJEUFL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbVJEUFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:05:10 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:23243 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030357AbVJEUFJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:05:09 -0400
Date: Wed, 5 Oct 2005 22:04:58 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Nix <nix@esperi.org.uk>
cc: 7eggert@gmx.de, Marc Perkel <marc@perkel.com>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <87vf0bg3y2.fsf@amaterasu.srvr.nix>
Message-ID: <Pine.LNX.4.58.0510052159250.4308@be1.lrz>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
 <4Uis4-4pZ-5@gated-at.bofh.it> <E1ENDIw-00012k-Fz@be1.lrz>
 <87vf0bg3y2.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2005, Nix wrote:
> On Wed, 05 Oct 2005, Bodo Eggert suggested tentatively:

[...]
> >                          and if utf-8 filenames are supposed to be used,
> >    an utf-8 checker rejecting non-canonialized strings will be desirable
> >    to avoid binary trash in filenames or lookalike filenames. The
> >    conversion to the canonialized form should happen outside the kernel.
> 
> Yes. But where? libc? (I can just see Ulrich going for *this*!)

Either there or in a seperate library.

> > b) ACK, I don't think caseless handling of filenames is a good thing,
> >    it would needlessly bloat the kernel by opening a can of worms.
> >    E.g. 'ß' would be converted to 'SS'[0] in German or 'B' in greek.
> 
> ... which means that either you lose per-process locale-dependence
> via LANG et all, or you get the possibility of directories containing
> several files with the same name from some users' POV.
> 
> Neither seems good to me; even though we already have part of this with
> NTFS, we should not inflict it on people needlessly.

ACK, that's my point.

-- 
Field experience is something you don't get until just after you need it. 
