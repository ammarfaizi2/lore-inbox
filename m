Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272935AbTG3QAL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272932AbTG3QAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:00:11 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:47578 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S272959AbTG3QAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:00:01 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Wakko Warner <wakko@animx.eu.org>
Date: Wed, 30 Jul 2003 17:59:39 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: matroxfb and 2.6.0-test2
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <8B72D532CC7@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jul 03 at 11:43, Wakko Warner wrote:
> > I assume that machine is otherwise OK. Can you capture 'dmesg' from
> > such boot and post them?
> 
> First: 2.6.0-test2 does not come up with a blank screen.

What is on screen? Correct 640x480 picture?

> Second: using fbset to set another mode (1024x768-60) causes a blank screen
> but changing vts gives me the screen back.  It must be using a different
> frequency since the screen is not inthe same place.  setting 680x480-60
> makes it look right again.  The actual resolution doesn't appear to change. 
> If I have enough written to the screen after issueing the 1024x768, the text
> becomes garbled (old text seems to interlace into current.

Do you use matroxfb-2.5.72 patch or not? You are not supposed to use
fbset on stock 2.6.x kernel (without patch above), you should use
stty cols & rows to set videomode under 2.6.x kernels (you can try
using fbset -pixclock to set refresh, but never change picture size
through fbset).
                                            Petr Vandrovec
                                            

