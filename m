Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262759AbSJCGQm>; Thu, 3 Oct 2002 02:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262760AbSJCGQm>; Thu, 3 Oct 2002 02:16:42 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:17421 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262759AbSJCGQl>; Thu, 3 Oct 2002 02:16:41 -0400
Message-Id: <200210030616.g936Gxp01048@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andreas Dilger <adilger@clusterfs.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC][PATCH]  4KB stack + irq stack for x86
Date: Thu, 3 Oct 2002 09:10:51 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-mm@kvack.org
References: <3D9B62AC.30607@us.ibm.com> <20021002215649.GY3000@clusterfs.com>
In-Reply-To: <20021002215649.GY3000@clusterfs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 October 2002 19:56, Andreas Dilger wrote:
> Alternately, you could set up an 8kB stack + IRQ stack and "red-zone"
> the high page of the current 8kB stack and see if it is ever used.

This debugging technique definitely works. Look how many sleeping calls
under locks apkm has caught recently!
--
vda
