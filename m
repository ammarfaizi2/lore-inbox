Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUAXW3L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 17:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUAXW3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 17:29:11 -0500
Received: from smtp06.auna.com ([62.81.186.16]:63161 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261812AbUAXW3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 17:29:08 -0500
Date: Sat, 24 Jan 2004 23:29:07 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Problem with module-init-tools
Message-ID: <20040124222907.GA4072@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have a problem with modprobe, 2.6.2-rc1-mm2, and agpgart.

With 2.4, I had this setup to have agpgart loaded:

alias char-major-226 agpgart

With 2.6 and the same setup, that module is loaded. But as agpgart backend is
now split, I need to load also intel-agp.ko. I read manuals, and corrected my
modprobe.conf this way:

install agpgart /sbin/modprobe intel-agp; /sbin/modprobe --ignore-install agpgart;

But it goes on an infinite loop :(.

I got this working with

alias char-major-226 intel-agp

How can I get the good old 'above' with new module init tools ?

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.2-rc1-jam2 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
