Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVCVVeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVCVVeU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVCVVdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:33:35 -0500
Received: from manson.clss.net ([65.211.158.2]:46740 "HELO manson.clss.net")
	by vger.kernel.org with SMTP id S262005AbVCVVbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:31:21 -0500
Message-ID: <20050322213114.20103.qmail@manson.clss.net>
From: "Alan Curry" <pacman-kernel@manson.clss.net>
Subject: Re: SVGATextMode on 2.6.11
To: aebr@win.tue.nl (Andries Brouwer)
Date: Tue, 22 Mar 2005 16:31:11 -0500 (EST)
Cc: akpm@osdl.org (Andrew Morton), linux-kernel@vger.kernel.org,
       eich@freedesktop.org
In-Reply-To: <20050322200616.GA4583@pclin040.win.tue.nl> from "Andries Brouwer" at Mar 22, 2005 09:06:16 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer writes the following:
>
>> "Alan Curry" <pacman-kernel@manson.clss.net> wrote:
>>> An SVGATextMode
>>> block cursor isn't affected by ^[c -- it truly *becomes* the default
>
>True - it is obtained by hardware reprogramming. But having lots of programs
>touch the hardware is getting less popular.

Yes, I realize that SVGATextMode is probably considered obsolete by now. If
the new cursor-restoring code actually solved a problem, SVGATextMode
breakage is an acceptable side effect.

>Concerning your 1. - You know that such an echo actually creates the VC?
>I still recall the times that there was not enough memory for more than
>four or five VCs, but probably you don't mind wasting a few hundred kB.

I did find a better way, as explained in a subsequent message: Set the
console font before changing the cursor, and don't touch it afterward.

