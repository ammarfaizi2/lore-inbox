Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268617AbRHFOWw>; Mon, 6 Aug 2001 10:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268628AbRHFOWo>; Mon, 6 Aug 2001 10:22:44 -0400
Received: from web11801.mail.yahoo.com ([216.136.172.155]:59145 "HELO
	web11801.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268617AbRHFOW0>; Mon, 6 Aug 2001 10:22:26 -0400
Message-ID: <20010806142236.78666.qmail@web11801.mail.yahoo.com>
Date: Mon, 6 Aug 2001 16:22:36 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Problem in Interrupt Handling ....
To: linux-kernel@vger.kernel.org
Cc: Venu Gopal Krishna Vemula <vvgkrishna_78@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But after some period (may be after 2 –3
> hours) recv interrupts are not coming (all other type
> of interrupts are Ok ..),  If I reset the ISR0
> (interrupt status register which contains  recv
> interrupt) and enable ISR0, recv interrupts are
> coming.

 You have an higher priority interrupt pending on the
 "kind of" UART. Probably you have had two interrupts
 (TxReady and RxFull) on the same IRQ and you have treated
 only one of them, or you have forgotten to treat a modem
 interrupt or... Look at the UART interrupt priorities
 in your documentation.
 This is excluding the obvious case "two serial lines shares
 the same IRQ".

  Hope that helps,
  Etienne.

___________________________________________________________
Do You Yahoo!? -- Vos albums photos en ligne, 
Yahoo! Photos : http://fr.photos.yahoo.com
