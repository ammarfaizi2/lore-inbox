Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268525AbUHLAmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268525AbUHLAmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268508AbUHLAdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:33:13 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:30660
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S268420AbUHLAOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:14:01 -0400
Date: Wed, 11 Aug 2004 20:12:18 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Alan Jenkins <sourcejedi@phonecoop.coop>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cd burning: kernel / userspace?
Message-ID: <20040812001218.GA20341@animx.eu.org>
References: <41189AA2.3010908@phonecoop.coop> <20040810220528.GA17537@animx.eu.org> <4119DFB0.6050204@phonecoop.coop> <20040811164109.GA18761@animx.eu.org> <411A89BB.60505@phonecoop.coop> <20040811213322.GA19908@animx.eu.org> <411A92EC.6090609@phonecoop.coop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411A92EC.6090609@phonecoop.coop>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, I'm not very good at this list / person CC stuff.  I sent a reply 
> to Valdis.Kletnieks@vt.edu, but forgot to CC to list.  Contents as follows:
> 
> I'm not sure this is necessary.  Can't you just do:
> 
> # dump -0 -B 700000 -u -z3 /home -f -| cdrecord /dev/hdb -
> 
> dump and cdrecord allow you to use "-" as a filename to indicate that 
> output shoud be written to stdout and input should be read from stdin 
> respectively.

Yes, but if I was to understand it right, dump will close/reopen at "700000"
(whatever that is, 700000kb?).  That won't work with cdrecord since it's
expecting a single input stream, not many seperated by a pause.  I'd
consider it more like using tar with the multiple tape option.  When it is
finished writing to a tape, it'll wait for the user to physically change
tapes and start writing at the beginning of the new tape.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
