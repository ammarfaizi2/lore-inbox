Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316668AbSFSODg>; Wed, 19 Jun 2002 10:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317742AbSFSODf>; Wed, 19 Jun 2002 10:03:35 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:50185 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316668AbSFSODe>;
	Wed, 19 Jun 2002 10:03:34 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The buggy APIC of the Abit BP6 
In-reply-to: Your message of "Wed, 19 Jun 2002 15:23:13 +0200."
             <005f01c21794$7702b520$020da8c0@nitemare> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 20 Jun 2002 00:03:19 +1000
Message-ID: <25764.1024495399@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2002 15:23:13 +0200, 
"Robbert Kouprie" <robbert@radium.jvb.tudelft.nl> wrote:
>I know the hardware sucks bad, but what's wrong with trying to work
>around the problem providing noone else is bugged by the workaround?

You do not have the data required to (a) detect the problem and (b)
recover even if you could detect the problem.  The APIC bus has a
single bit checksum, the APIC hardware detects single bit errors and
does a retransmission.  It _cannot_ detect double bit errors, the bad
data is accepted and processed with undefined side effects.

What you see in the logs for a BP6 are error messages for single bit
errors that were recovered by the hardware.  You will never see
messages for double bit errors, just unexplained oops and/or machine
hangs.

Yes, I have a BP6 :(.

