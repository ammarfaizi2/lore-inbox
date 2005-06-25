Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVFYW4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVFYW4k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 18:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVFYW4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 18:56:40 -0400
Received: from web54501.mail.yahoo.com ([68.142.225.171]:62290 "HELO
	web54501.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261378AbVFYWzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 18:55:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=eoqz2CPLBmgUHK8XlRAxmXFpTcUsUJHHrRptWpL6x9qXhwNGgNPMnIGycEj5Bbs8Ucwx4LLUH/aCl1i+d4qgdguvcKyUosO6D5eIazW8PPIACY4++RiAUX/1P/bUodjm20JkMgRGe9v0qLTB/4cAJlLaD2NqJyndIDAk39iUXzE=  ;
Message-ID: <20050625225546.54532.qmail@web54501.mail.yahoo.com>
Date: Sat, 25 Jun 2005 19:55:46 -0300 (ART)
From: Joilnen Leite <knl_joi@yahoo.com.br>
Subject: early_cpu_init
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

in the function:
early_cpu_init we could to change to avoid initialize
unecessary code ?

arch/i386/cpu/common.c:536
void __init early_cpu_init(void)
{
#ifdef CONFIG_MCYRIXIII         
         cyrix_init_cpu();
#elif defined CONFIG_MGODE6X1
         nsc_init_cpu();
#elif defined CONFIG_MK6 || defined CONFIG_MK7
||defined CONFIG_MK8
         amd_init_cpu();
#elif defined CONFIG_CRUSOE || defined CONFIG_EFFICEON
         transmeta_init_cpu();
#elif defined OTHERS_THAT_I_DONT_KNOW
         centaur_init_cpu();
         rise_init_cpu();
         nexgen_init_cpu();
         umc_init_cpu();
         early_cpu_detect();
#else
         intel_cpu_init();

just only a idea.

thanks Joilnen


	
	
		
_______________________________________________________ 
Yahoo! Acesso Grátis - Internet rápida e grátis. 
Instale o discador agora! http://br.acesso.yahoo.com/
