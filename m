Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265499AbUHPHir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbUHPHir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 03:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265743AbUHPHir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 03:38:47 -0400
Received: from proxy.vc-graz.ac.at ([193.171.121.30]:34262 "EHLO
	proxy.vc-graz.ac.at") by vger.kernel.org with ESMTP id S265499AbUHPHiq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 03:38:46 -0400
From: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Date: Mon, 16 Aug 2004 09:40:02 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200408160940.02849.worf@sbox.tu-graz.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Wendel wrote:

> K3B detects my Lite-on LTR-52327S CDRW as a CDROM when run with 2.6.8.1.
> Booting back into 2.6.7 corrects the problem.

I have the same problem.
I found out that cdrecord has a empty Line for the supported modes.
( not k3b fault )

cdrecord -checkdrive with kernel 2.6.7 (vanilla) gives:
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
with kernel 2.6.8 :
Supported modes:      ( the rest is blank )

Trying to burn anyway leads to "not supported mode" messages.

my system: Athlon on nforce2 board, LITE-ON brenner LTR-52327S, gcc 3.4.1

Worf
