Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVE0Jko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVE0Jko (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVE0JiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:38:18 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:35564 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262419AbVE0JgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:36:11 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: <cutaway@bellsouth.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 387 emulator hack - mutant AAD trick - any objections?
Date: Fri, 27 May 2005 12:35:41 +0300
User-Agent: KMail/1.5.4
References: <007001c56290$25dd4d00$2800000a@pc365dualp2>
In-Reply-To: <007001c56290$25dd4d00$2800000a@pc365dualp2>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505271235.41353.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 May 2005 10:44, cutaway@bellsouth.net wrote:
> Brain fade...example should be:
> 
> 1) Start with AX = 0x0023
> 2) Execute AAM instruction
> 3) Now AX = 0x0305 (unpacked BCD)
> 4) Execute base 16 AAD instruction
> 5) Now AX = 0x0035 (packed BCD)

Intel syntax:

shl ah,4
or al,ah
mov ah,0  (if needed)

No need to use AAD16, it is 
a) doesnt work on some obscure ancient NEC x86 clones IIRC
b) is microcoded (slow)
--
vda

