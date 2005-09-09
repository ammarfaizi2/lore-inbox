Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbVIIK40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbVIIK40 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 06:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbVIIK40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 06:56:26 -0400
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:634 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030234AbVIIK4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 06:56:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Content-Disposition:From:To:Subject:Date:User-Agent:MIME-Version:Message-Id:Cc:Content-Type:Content-Transfer-Encoding;
  b=zL0q4zFy4lWiRbxQj5aadR+GRsUE2G2Y+RNe4JFcunOUuNtNqcb0kMcVlmFvsZ2Z0Dn6LSALC/96t2lU7xu2PzUrefXrrHJm7Oqwy0Z74WLd77FYAYyOt68sKjBGVxPp52ExycxUAKy/74fu9/8lDo+xA8lekq3GUTqi5keTXv4=  ;
Content-Disposition: inline
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: torvalds@osdl.org
Subject: [PATCH] Fix misspelled i8259 typo in io_apic.c
Date: Fri, 9 Sep 2005 12:59:04 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Message-Id: <200509091259.05017.annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy PIC's name is "i8259".

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>


diff -upr linux-2.6.13-rc6/arch/i386/kernel/io_apic.c linux-2.6.13/arch/i386/kernel/io_apic.c
--- linux-2.6.13-rc6/arch/i386/kernel/io_apic.c	2005-08-08 11:46:00.000000000 +0200
+++ linux-2.6.13/arch/i386/kernel/io_apic.c	2005-08-08 13:24:52.000000000 +0200
@@ -1641,9 +1641,9 @@ void disable_IO_APIC(void)
 	clear_IO_APIC();
 
 	/*
-	 * If the i82559 is routed through an IOAPIC
+	 * If the i8259 is routed through an IOAPIC
 	 * Put that IOAPIC in virtual wire mode
-	 * so legacy interrups can be delivered.
+	 * so legacy interrupts can be delivered.
 	 */
 	pin = find_isa_irq_pin(0, mp_ExtINT);
 	if (pin != -1) {
diff -upr linux-2.6.13-rc6/arch/x86_64/kernel/io_apic.c linux-2.6.13/arch/x86_64/kernel/io_apic.c
--- linux-2.6.13-rc6/arch/x86_64/kernel/io_apic.c	2005-08-08 11:46:01.000000000 +0200
+++ linux-2.6.13/arch/x86_64/kernel/io_apic.c	2005-08-08 13:25:09.000000000 +0200
@@ -1138,9 +1138,9 @@ void disable_IO_APIC(void)
 	clear_IO_APIC();
 
 	/*
-	 * If the i82559 is routed through an IOAPIC
+	 * If the i8259 is routed through an IOAPIC
 	 * Put that IOAPIC in virtual wire mode
-	 * so legacy interrups can be delivered.
+	 * so legacy interrupts can be delivered.
 	 */
 	pin = find_isa_irq_pin(0, mp_ExtINT);
 	if (pin != -1) {
_

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
