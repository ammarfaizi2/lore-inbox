Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262973AbTCKQ5e>; Tue, 11 Mar 2003 11:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262971AbTCKQ5e>; Tue, 11 Mar 2003 11:57:34 -0500
Received: from thunk.org ([140.239.227.29]:15286 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262970AbTCKQ5d>;
	Tue, 11 Mar 2003 11:57:33 -0500
Date: Tue, 11 Mar 2003 04:07:03 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ed Vance <EdV@macrolink.com>
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org,
       Bryan Whitehead <driver@jpl.nasa.gov>
Subject: Re: devfs + PCI serial card = no extra serial ports
Message-ID: <20030311090703.GA13389@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ed Vance <EdV@macrolink.com>, linux-kernel@vger.kernel.org,
	linux-newbie@vger.kernel.org, Bryan Whitehead <driver@jpl.nasa.gov>
References: <11E89240C407D311958800A0C9ACF7D1A33DD5@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33DD5@EXCHANGE>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 03:57:56PM -0800, Ed Vance wrote:
> 
> Will Bryan get the proper devfs entries if he patches serial.c to 
> recognize his card at kernel initialization, or is there more 
> weirdness expected? 

The point is that with devfs, it requires a kernel patch.  And if you
have an ISA card, where you can't do this kind of autoconfiguration,
and you're using devfs, you're *toast*.  Without devfs, you just use
setserial to configure the necessary ports, and you're done.

(Granted, these days, the last point may not matter since ISA is
getting killed off pretty effectively by Microsoft refusing the
certify systems against recent Windows OS's if they contain ISA buses
--- one of the good things Microsoft has done for the computer
industry.  :-)

						- Ted
