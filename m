Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270676AbUJUNQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270676AbUJUNQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268831AbUJUNOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:14:03 -0400
Received: from mail.charite.de ([160.45.207.131]:19908 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S268655AbUJUNNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 09:13:13 -0400
Date: Thu, 21 Oct 2004 15:13:11 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-ac1 doesn't compile
Message-ID: <20041021131311.GT17874@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041021125154.GL17874@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041021125154.GL17874@charite.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:

> drivers/usb/core/hcd.c:132: error: parse error before '>>' token
> drivers/usb/core/hcd.c:132: error: initializer element is not constant

Adrian's patch fixes this

--- linux-2.6.9-ac1-full/Makefile.old
+++ linux-2.6.9-ac1-full/Makefile
@@ -1,7 +1,7 @@                    
 VERSION = 2                 
 PATCHLEVEL = 6                    
-SUBLEVEL = 9-ac1                      
-EXTRAVERSION =                    
+SUBLEVEL = 9                  
+EXTRAVERSION = -ac1                         
 NAME=AC 1               
     
# *DOCUMENTATION*                       

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                                   AIM.  ralfpostfix
