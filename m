Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbTILSgz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbTILSfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:35:48 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:10984 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261809AbTILSeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:34:05 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Date: Fri, 12 Sep 2003 20:33:24 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Another keyboard woes with 2.6.0...
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <2F284368A@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Sep 03 at 13:45, Zwane Mwaikambo wrote:

> On Fri, 12 Sep 2003, Petr Vandrovec wrote:
> 
> >    I have MicroStar MS-9211 box with connected to the KVM switch
> > MasterView CS-1016, which is connected to the some Chicony
> > keyboard. 2.4.x kernel works without problem, but when 2.6.0
> > starts, immediately after input device driver is initialized it starts
> > thinking that F7 key is held down, and it stays that way until
> > I hit some other key to stop autorepeat... What debugging I
> > can do for you to get rid of screen full of '^[[18~' ? /bin/login
> > continuously complains about username being too long :-(
> 
> Hi Petr,
>     I have the same problem with an Avocent SwitchView and Keytronic 
> keyboard, although it doesn't sound as bad as your problem. Occasionally 
> some keys just repeat until i press another key. I'm not quite sure what 
> kind of information Vojtech would like. The machine is 440BX based and 
> kernel is 2.6.0-test3-mm1

Andries is already gathering info for this one. This problem (missed
key release) happens to me on all systems I have (Athlon + via, P3 + i440BX,
P4 + 845...), most often when I do alt+right-arrow for walking through
consoles (and for Andries: hitting key stops this, otherwise it 
endlessly switches all VTs around, and while kernel thinks that key
is down, keyboard actually does not generate any IRQs, so keyboard knows
that all keys are released).
                                                Petr
                                                

