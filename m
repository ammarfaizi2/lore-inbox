Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317047AbSFKNug>; Tue, 11 Jun 2002 09:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317049AbSFKNuf>; Tue, 11 Jun 2002 09:50:35 -0400
Received: from hm61.locaweb.com.br ([200.213.197.161]:54914 "HELO
	hm61.locaweb.com.br") by vger.kernel.org with SMTP
	id <S317047AbSFKNuf>; Tue, 11 Jun 2002 09:50:35 -0400
Message-ID: <20020611135017.5201.qmail@hm36.locaweb.com.br>
From: "Renato" <webmaster@cienciapura.com.br>
Date: Tue, 11 Jun 2002 10:50:17
To: linux-kernel@vger.kernel.org
Subject: Problems with e1000 driver and ksoftirqd_CPU0
In-Reply-To: <02061116333800.01217@fortress.mirotel.net>
X-Mailer: LocaWeb Mail
X-IPAddress: 200.192.44.199
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm just using the latest kernel from RedHat - 2.4.18-4smp ( which I 
suppose it mostly -ac series ) and I'm having real problems with an 
Ethernet Gigabit network. It looks like "ksoftirqd_CPU0" eats up all the 
CPU processing with a traffic of just 55 Mbps !! ( it's not my hardware... 
I'm using a Dual Xeon 2Ghz and with kernel 2.4.9 it could handle easily 85 
Mbps ) 

'vmstat 1' output:
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  
sy  id
 0  0  1      0 1988284   2528  17052   0   0     0     0  826   352   0  
16  84
 0  0  0      0 1988264   2528  17052   0   0     0     0 17486    51   0  
25  75
 0  0  1      0 1988264   2528  17052   0   0     0     0 17661    29   0  
25  75
 0  0  1      0 1988264   2528  17052   0   0     0     0 17424    32   0  
25  75
 0  0  1      0 1988264   2528  17052   0   0     0     0 17428    42   0  
25  75
 0  0  1      0 1988264   2528  17052   0   0     0     0 17572    46   0  
25  75

( with 2.4.9 interrupt rate was over 50.000 !! )

lsmod output:

Module                  Size  Used by    Tainted: P  
ipchains               46184 162 
e1000                  57508   2 
raid1                  15780   2 
aic7xxx               125440   6 
sd_mod                 12896  12 
scsi_mod              112272   2  [aic7xxx sd_mod]

( I don't rules loaded that could impact performance )

Anybody ? 

Renato - Brazil.

