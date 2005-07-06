Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVGFMQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVGFMQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 08:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVGFMQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 08:16:40 -0400
Received: from mail.riseup.net ([69.90.134.155]:28081 "EHLO mail.riseup.net")
	by vger.kernel.org with ESMTP id S262219AbVGFJTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 05:19:15 -0400
Date: Wed, 6 Jul 2005 11:22:02 +0200
From: st3@riseup.net
To: linux-kernel@vger.kernel.org
Subject: speedstep-centrino on dothan
Message-ID: <20050706112202.33d63d4d@horst.morte.male>
X-Mailer: Sylpheed-Claws 1.9.12 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the speedstep-centrino support has built-in frequency/voltage
pairs only for Banias CPUs. For Dothan CPUs, these tables are read from
BIOS ACPI.

But ACPI encoding may not be available or not reliable, so why shouldn't we
provide built-in tables for Dothan CPUs, too? Intel has released this
datasheet:

http://www.intel.com/design/mobile/datashts/302189.htm

with frequency/voltage pairs for every version of Dothan CPUs.

Moreover, I checked on Pentium M 725 and Pentium M 715 that the lowest
frequency at which the CPU can be set safely is not the 600MHz given in
datasheets, but 400MHz instead, with VID#A, VID#B, VID#C and VID#D (see
datasheet for more details) set to 0.908V.

I can provide a patch, let me know.


--
ciao
st3

