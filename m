Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275636AbTHOA3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 20:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275635AbTHOA3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 20:29:30 -0400
Received: from imap.gmx.net ([213.165.64.20]:31427 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S275628AbTHOA1d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 20:27:33 -0400
Content-Type: text/plain;
  charset="utf-8"
From: Akon <akon@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Double-Harvard Architectures
Date: Fri, 15 Aug 2003 02:26:36 +0200
User-Agent: KMail/1.4.3
References: <000601c362bf$7eadc9a0$62a14943@joe> <200308142009.53875.admin@kentonet.net>
In-Reply-To: <200308142009.53875.admin@kentonet.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200308150226.36787.akon@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiall,

does someone have experience in porting some Kernel to Double-Harvard-Arch?
I don't think Lx was ever ported to such a kind of µP (please correct me!), 
all I found on the web were several ports to embedded, but still vNeumann-, 
or Single-Harvard µPs.

DH means, that the µprocessor (typically a DSP) has a seperated program 
memory, a seperate (X)Data memory and a seperate (Y)Data mem, so it can 
fetch two data adresses simultanely in one cycle via two physically 
independent mem ports. For DSPs, that's a common behaviour!

So, obviously one (me) will have to integrate two flavours of malloc() 
into the Kernel (vmallocX() and vmallocY()). Of course, i could leave this 
issue to a specialized (uC)glibc, but i think, it should be the job of the 
kernel to keep the oversight on memory issues...;)

Any ideas how to manage that trouble as "frictionless" as can?,
And¡

