Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143413AbREKWgD>; Fri, 11 May 2001 18:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143414AbREKWfx>; Fri, 11 May 2001 18:35:53 -0400
Received: from jalon.able.es ([212.97.163.2]:61914 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S143413AbREKWfm>;
	Fri, 11 May 2001 18:35:42 -0400
Date: Sat, 12 May 2001 00:35:34 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "Martin . Knoblauch" <Martin.Knoblauch@TeraPort.de>
Cc: "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: Size of /proc/kcore growing over time ?
Message-ID: <20010512003534.A1060@werewolf.able.es>
In-Reply-To: <3AFBE5BF.5865B0CA@TeraPort.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3AFBE5BF.5865B0CA@TeraPort.de>; from Martin.Knoblauch@TeraPort.de on Fri, May 11, 2001 at 15:14:39 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.11 Martin.Knoblauch wrote:
> 
>  I ask, because I thought the size of kproc could be used to determine
> the amount of physical memory. If this assumption is wrong, is there
> another way to achive the goal?
> 

#include <sys/sysinfo.h> // for get_phys_pages()
#include <unistd.h> // for getpagesize()

ram = get_phys_pages()*getpagesize();

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.4-ac6 #1 SMP Wed May 9 14:28:00 CEST 2001 i686

