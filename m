Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317478AbSFDKyb>; Tue, 4 Jun 2002 06:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317479AbSFDKya>; Tue, 4 Jun 2002 06:54:30 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:58815 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S317478AbSFDKyP>; Tue, 4 Jun 2002 06:54:15 -0400
From: Matthias Welk <welk@fokus.gmd.de>
Organization: Fraunhofer Fokus
To: linux-kernel@vger.kernel.org
Subject: nfs slowdown since 2.5.4
Date: Tue, 4 Jun 2002 12:53:44 +0200
User-Agent: KMail/1.4.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4wJ/8COkqfjDkfn"
Message-Id: <200206041253.44446.welk@fokus.gmd.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_4wJ/8COkqfjDkfn
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

since 2.5.4 I noticed a big slowdown in nfs.
It seems that this is related to the changes in the nfs-lookup code, becaus=
e=20
now most traffic via nfs is for lookup- and getattr-calls as you can see=20
in the attached tcpdump log.
I'v also attached a log of nfsstat, which shows this problem too.

Greetings, Matthias.

(Log's created under 2.5.20)
=2D-=20
=2D--------------------------------------------------------------
=46rom: Matthias Welk                   office:  +49-30-3463-7272
      FHG Fokus                       mobile:  +49-179- 1144752
      Kaiserin-Augusta-Allee 31       fax   :  +49-30-3463-8672
      10589 Berlin		      email : welk@fokus.fhg.de
=2D---------------------------------------------------------------


--Boundary-00=_4wJ/8COkqfjDkfn
Content-Type: text/x-log;
  charset="us-ascii";
  name="tcpdum.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="tcpdum.log"

21:10:17.180168 buruk.fokus.gmd.de.2498678203 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.180452 armada.nfs > buruk.fokus.gmd.de.2498678203: reply ok 240 lookup [|nfs]
21:10:17.180784 buruk.fokus.gmd.de.2515455419 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.181007 armada.nfs > buruk.fokus.gmd.de.2515455419: reply ok 240 lookup [|nfs]
21:10:17.181056 buruk.fokus.gmd.de.2532232635 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.181310 armada.nfs > buruk.fokus.gmd.de.2532232635: reply ok 240 lookup [|nfs]
21:10:17.181351 buruk.fokus.gmd.de.2549009851 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.181582 armada.nfs > buruk.fokus.gmd.de.2549009851: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.181618 buruk.fokus.gmd.de.2565787067 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.181875 armada.nfs > buruk.fokus.gmd.de.2565787067: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.181907 buruk.fokus.gmd.de.2582564283 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.182172 armada.nfs > buruk.fokus.gmd.de.2582564283: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.182217 buruk.fokus.gmd.de.2599341499 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.182485 armada.nfs > buruk.fokus.gmd.de.2599341499: reply ok 240 lookup [|nfs]
21:10:17.182814 buruk.fokus.gmd.de.2616118715 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.183076 armada.nfs > buruk.fokus.gmd.de.2616118715: reply ok 240 lookup [|nfs]
21:10:17.183125 buruk.fokus.gmd.de.2632895931 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.183378 armada.nfs > buruk.fokus.gmd.de.2632895931: reply ok 240 lookup [|nfs]
21:10:17.183414 buruk.fokus.gmd.de.2649673147 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.183636 armada.nfs > buruk.fokus.gmd.de.2649673147: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.183665 buruk.fokus.gmd.de.2666450363 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.183933 armada.nfs > buruk.fokus.gmd.de.2666450363: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.183962 buruk.fokus.gmd.de.2683227579 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.184231 armada.nfs > buruk.fokus.gmd.de.2683227579: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.184267 buruk.fokus.gmd.de.2700004795 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.184530 armada.nfs > buruk.fokus.gmd.de.2700004795: reply ok 116 lookup ERROR: No such file or directory
21:10:17.184572 buruk.fokus.gmd.de.2716782011 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.184847 armada.nfs > buruk.fokus.gmd.de.2716782011: reply ok 240 lookup [|nfs]
21:10:17.184890 buruk.fokus.gmd.de.2733559227 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.185141 armada.nfs > buruk.fokus.gmd.de.2733559227: reply ok 240 lookup [|nfs]
21:10:17.185174 buruk.fokus.gmd.de.2750336443 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.185413 armada.nfs > buruk.fokus.gmd.de.2750336443: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.185442 buruk.fokus.gmd.de.2767113659 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.185704 armada.nfs > buruk.fokus.gmd.de.2767113659: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.185733 buruk.fokus.gmd.de.2783890875 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.186002 armada.nfs > buruk.fokus.gmd.de.2783890875: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.186057 buruk.fokus.gmd.de.2800668091 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.186290 armada.nfs > buruk.fokus.gmd.de.2800668091: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.186322 buruk.fokus.gmd.de.2817445307 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.186589 armada.nfs > buruk.fokus.gmd.de.2817445307: reply ok 116 lookup ERROR: No such file or directory
21:10:17.186629 buruk.fokus.gmd.de.2834222523 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.186911 armada.nfs > buruk.fokus.gmd.de.2834222523: reply ok 240 lookup [|nfs]
21:10:17.186955 buruk.fokus.gmd.de.2850999739 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.187208 armada.nfs > buruk.fokus.gmd.de.2850999739: reply ok 240 lookup [|nfs]
21:10:17.187243 buruk.fokus.gmd.de.2867776955 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.187476 armada.nfs > buruk.fokus.gmd.de.2867776955: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.187507 buruk.fokus.gmd.de.2884554171 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.187769 armada.nfs > buruk.fokus.gmd.de.2884554171: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.187798 buruk.fokus.gmd.de.2901331387 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.188066 armada.nfs > buruk.fokus.gmd.de.2901331387: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.188095 buruk.fokus.gmd.de.2918108603 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.188359 armada.nfs > buruk.fokus.gmd.de.2918108603: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.188389 buruk.fokus.gmd.de.2934885819 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.188657 armada.nfs > buruk.fokus.gmd.de.2934885819: reply ok 116 lookup ERROR: No such file or directory
21:10:17.188696 buruk.fokus.gmd.de.2951663035 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.188986 armada.nfs > buruk.fokus.gmd.de.2951663035: reply ok 240 lookup [|nfs]
21:10:17.189030 buruk.fokus.gmd.de.2968440251 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.189272 armada.nfs > buruk.fokus.gmd.de.2968440251: reply ok 240 lookup [|nfs]
21:10:17.189306 buruk.fokus.gmd.de.2985217467 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.189539 armada.nfs > buruk.fokus.gmd.de.2985217467: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.189567 buruk.fokus.gmd.de.3001994683 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.189837 armada.nfs > buruk.fokus.gmd.de.3001994683: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.189865 buruk.fokus.gmd.de.3018771899 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.190131 armada.nfs > buruk.fokus.gmd.de.3018771899: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.190159 buruk.fokus.gmd.de.3035549115 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.190423 armada.nfs > buruk.fokus.gmd.de.3035549115: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.190452 buruk.fokus.gmd.de.3052326331 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.190726 armada.nfs > buruk.fokus.gmd.de.3052326331: reply ok 116 lookup ERROR: No such file or directory
21:10:17.190764 buruk.fokus.gmd.de.3069103547 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.191043 armada.nfs > buruk.fokus.gmd.de.3069103547: reply ok 240 lookup [|nfs]
21:10:17.191086 buruk.fokus.gmd.de.3085880763 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.191336 armada.nfs > buruk.fokus.gmd.de.3085880763: reply ok 240 lookup [|nfs]
21:10:17.191371 buruk.fokus.gmd.de.3102657979 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.191604 armada.nfs > buruk.fokus.gmd.de.3102657979: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.191632 buruk.fokus.gmd.de.3119435195 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.191901 armada.nfs > buruk.fokus.gmd.de.3119435195: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.191929 buruk.fokus.gmd.de.3136212411 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.192194 armada.nfs > buruk.fokus.gmd.de.3136212411: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.192222 buruk.fokus.gmd.de.3152989627 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.192487 armada.nfs > buruk.fokus.gmd.de.3152989627: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.192519 buruk.fokus.gmd.de.3169766843 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.192785 armada.nfs > buruk.fokus.gmd.de.3169766843: reply ok 116 lookup ERROR: No such file or directory
21:10:17.192823 buruk.fokus.gmd.de.3186544059 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.193107 armada.nfs > buruk.fokus.gmd.de.3186544059: reply ok 240 lookup [|nfs]
21:10:17.193151 buruk.fokus.gmd.de.3203321275 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.193396 armada.nfs > buruk.fokus.gmd.de.3203321275: reply ok 240 lookup [|nfs]
21:10:17.193667 buruk.fokus.gmd.de.3220098491 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.193865 armada.nfs > buruk.fokus.gmd.de.3220098491: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.193896 buruk.fokus.gmd.de.3236875707 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.194162 armada.nfs > buruk.fokus.gmd.de.3236875707: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.194194 buruk.fokus.gmd.de.3253652923 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.194454 armada.nfs > buruk.fokus.gmd.de.3253652923: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.194484 buruk.fokus.gmd.de.3270430139 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.194749 armada.nfs > buruk.fokus.gmd.de.3270430139: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.194780 buruk.fokus.gmd.de.3287207355 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.195046 armada.nfs > buruk.fokus.gmd.de.3287207355: reply ok 116 lookup ERROR: No such file or directory
21:10:17.195090 buruk.fokus.gmd.de.3303984571 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.195363 armada.nfs > buruk.fokus.gmd.de.3303984571: reply ok 240 lookup [|nfs]
21:10:17.195408 buruk.fokus.gmd.de.3320761787 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.195661 armada.nfs > buruk.fokus.gmd.de.3320761787: reply ok 240 lookup [|nfs]
21:10:17.195695 buruk.fokus.gmd.de.3337539003 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.195931 armada.nfs > buruk.fokus.gmd.de.3337539003: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.196179 buruk.fokus.gmd.de.3354316219 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.196423 armada.nfs > buruk.fokus.gmd.de.3354316219: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.196454 buruk.fokus.gmd.de.3371093435 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.196716 armada.nfs > buruk.fokus.gmd.de.3371093435: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.196744 buruk.fokus.gmd.de.3387870651 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.197013 armada.nfs > buruk.fokus.gmd.de.3387870651: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.197048 buruk.fokus.gmd.de.3404647867 > armada.nfs: 160 lookup [|nfs] (DF)
21:10:17.197311 armada.nfs > buruk.fokus.gmd.de.3404647867: reply ok 116 lookup ERROR: No such file or directory
21:10:17.197353 buruk.fokus.gmd.de.3421425083 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.197625 armada.nfs > buruk.fokus.gmd.de.3421425083: reply ok 240 lookup [|nfs]
21:10:17.197669 buruk.fokus.gmd.de.3438202299 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.197923 armada.nfs > buruk.fokus.gmd.de.3438202299: reply ok 240 lookup [|nfs]
21:10:17.197958 buruk.fokus.gmd.de.3454979515 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.198195 armada.nfs > buruk.fokus.gmd.de.3454979515: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.198223 buruk.fokus.gmd.de.3471756731 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.198491 armada.nfs > buruk.fokus.gmd.de.3471756731: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.198520 buruk.fokus.gmd.de.3488533947 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.198784 armada.nfs > buruk.fokus.gmd.de.3488533947: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.198813 buruk.fokus.gmd.de.3505311163 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.199077 armada.nfs > buruk.fokus.gmd.de.3505311163: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.199120 buruk.fokus.gmd.de.3522088379 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.199400 armada.nfs > buruk.fokus.gmd.de.3522088379: reply ok 240 lookup [|nfs]
21:10:17.199440 buruk.fokus.gmd.de.3538865595 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.199674 armada.nfs > buruk.fokus.gmd.de.3538865595: reply ok 116 lookup ERROR: No such file or directory
21:10:17.199712 buruk.fokus.gmd.de.3555642811 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.199991 armada.nfs > buruk.fokus.gmd.de.3555642811: reply ok 240 lookup [|nfs]
21:10:17.200026 buruk.fokus.gmd.de.3572420027 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.200263 armada.nfs > buruk.fokus.gmd.de.3572420027: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.200293 buruk.fokus.gmd.de.3589197243 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.200556 armada.nfs > buruk.fokus.gmd.de.3589197243: reply ok 116 lookup ERROR: No such file or directory
21:10:17.200638 buruk.fokus.gmd.de.3605974459 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.200888 armada.nfs > buruk.fokus.gmd.de.3605974459: reply ok 240 lookup [|nfs]
21:10:17.200924 buruk.fokus.gmd.de.3622751675 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.201151 armada.nfs > buruk.fokus.gmd.de.3622751675: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.201181 buruk.fokus.gmd.de.3639528891 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.201446 armada.nfs > buruk.fokus.gmd.de.3639528891: reply ok 116 lookup ERROR: No such file or directory
21:10:17.201484 buruk.fokus.gmd.de.3656306107 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.201767 armada.nfs > buruk.fokus.gmd.de.3656306107: reply ok 240 lookup [|nfs]
21:10:17.201803 buruk.fokus.gmd.de.3673083323 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.202039 armada.nfs > buruk.fokus.gmd.de.3673083323: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.202069 buruk.fokus.gmd.de.3689860539 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.202356 armada.nfs > buruk.fokus.gmd.de.3689860539: reply ok 116 lookup ERROR: No such file or directory
21:10:17.202395 buruk.fokus.gmd.de.3706637755 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.202664 armada.nfs > buruk.fokus.gmd.de.3706637755: reply ok 240 lookup [|nfs]
21:10:17.202701 buruk.fokus.gmd.de.3723414971 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.202927 armada.nfs > buruk.fokus.gmd.de.3723414971: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.202957 buruk.fokus.gmd.de.3740192187 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.203220 armada.nfs > buruk.fokus.gmd.de.3740192187: reply ok 116 lookup ERROR: No such file or directory
21:10:17.203258 buruk.fokus.gmd.de.3756969403 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.203543 armada.nfs > buruk.fokus.gmd.de.3756969403: reply ok 240 lookup [|nfs]
21:10:17.203579 buruk.fokus.gmd.de.3773746619 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.203815 armada.nfs > buruk.fokus.gmd.de.3773746619: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.203845 buruk.fokus.gmd.de.3790523835 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.204108 armada.nfs > buruk.fokus.gmd.de.3790523835: reply ok 116 lookup ERROR: No such file or directory
21:10:17.204146 buruk.fokus.gmd.de.3807301051 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.204431 armada.nfs > buruk.fokus.gmd.de.3807301051: reply ok 240 lookup [|nfs]
21:10:17.204466 buruk.fokus.gmd.de.3824078267 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.204698 armada.nfs > buruk.fokus.gmd.de.3824078267: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.204730 buruk.fokus.gmd.de.3840855483 > armada.nfs: 160 lookup [|nfs] (DF)
21:10:17.205001 armada.nfs > buruk.fokus.gmd.de.3840855483: reply ok 116 lookup ERROR: No such file or directory
21:10:17.205040 buruk.fokus.gmd.de.3857632699 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.205314 armada.nfs > buruk.fokus.gmd.de.3857632699: reply ok 240 lookup [|nfs]
21:10:17.205347 buruk.fokus.gmd.de.3874409915 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.205586 armada.nfs > buruk.fokus.gmd.de.3874409915: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.205770 buruk.fokus.gmd.de.3891187131 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.206006 armada.nfs > buruk.fokus.gmd.de.3891187131: reply ok 240 lookup [|nfs]
21:10:17.206195 buruk.fokus.gmd.de.3907964347 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.206470 armada.nfs > buruk.fokus.gmd.de.3907964347: reply ok 116 lookup ERROR: No such file or directory
21:10:17.206512 buruk.fokus.gmd.de.3924741563 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.206787 armada.nfs > buruk.fokus.gmd.de.3924741563: reply ok 240 lookup [|nfs]
21:10:17.206821 buruk.fokus.gmd.de.3941518779 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.207059 armada.nfs > buruk.fokus.gmd.de.3941518779: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.207090 buruk.fokus.gmd.de.3958295995 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.207353 armada.nfs > buruk.fokus.gmd.de.3958295995: reply ok 116 lookup ERROR: No such file or directory
21:10:17.207435 buruk.fokus.gmd.de.3975073211 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.207675 armada.nfs > buruk.fokus.gmd.de.3975073211: reply ok 240 lookup [|nfs]
21:10:17.207711 buruk.fokus.gmd.de.3991850427 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.207942 armada.nfs > buruk.fokus.gmd.de.3991850427: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.207973 buruk.fokus.gmd.de.4008627643 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.208241 armada.nfs > buruk.fokus.gmd.de.4008627643: reply ok 116 lookup ERROR: No such file or directory
21:10:17.208280 buruk.fokus.gmd.de.4025404859 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.208558 armada.nfs > buruk.fokus.gmd.de.4025404859: reply ok 240 lookup [|nfs]
21:10:17.208593 buruk.fokus.gmd.de.4042182075 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.208825 armada.nfs > buruk.fokus.gmd.de.4042182075: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.208856 buruk.fokus.gmd.de.4058959291 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.209119 armada.nfs > buruk.fokus.gmd.de.4058959291: reply ok 116 lookup ERROR: No such file or directory
21:10:17.209159 buruk.fokus.gmd.de.4075736507 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.209442 armada.nfs > buruk.fokus.gmd.de.4075736507: reply ok 240 lookup [|nfs]
21:10:17.209476 buruk.fokus.gmd.de.4092513723 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.209714 armada.nfs > buruk.fokus.gmd.de.4092513723: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.209745 buruk.fokus.gmd.de.4109290939 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.210002 armada.nfs > buruk.fokus.gmd.de.4109290939: reply ok 116 lookup ERROR: No such file or directory
21:10:17.210041 buruk.fokus.gmd.de.4126068155 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.210329 armada.nfs > buruk.fokus.gmd.de.4126068155: reply ok 240 lookup [|nfs]
21:10:17.210363 buruk.fokus.gmd.de.4142845371 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.210597 armada.nfs > buruk.fokus.gmd.de.4142845371: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.210627 buruk.fokus.gmd.de.4159622587 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.210890 armada.nfs > buruk.fokus.gmd.de.4159622587: reply ok 116 lookup ERROR: No such file or directory
21:10:17.210929 buruk.fokus.gmd.de.4176399803 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.211213 armada.nfs > buruk.fokus.gmd.de.4176399803: reply ok 240 lookup [|nfs]
21:10:17.211246 buruk.fokus.gmd.de.4193177019 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.211480 armada.nfs > buruk.fokus.gmd.de.4193177019: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.211513 buruk.fokus.gmd.de.4209954235 > armada.nfs: 160 lookup [|nfs] (DF)
21:10:17.211778 armada.nfs > buruk.fokus.gmd.de.4209954235: reply ok 116 lookup ERROR: No such file or directory
21:10:17.211818 buruk.fokus.gmd.de.4226731451 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.212091 armada.nfs > buruk.fokus.gmd.de.4226731451: reply ok 240 lookup [|nfs]
21:10:17.212125 buruk.fokus.gmd.de.4243508667 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.212363 armada.nfs > buruk.fokus.gmd.de.4243508667: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.212536 buruk.fokus.gmd.de.4260285883 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.212787 armada.nfs > buruk.fokus.gmd.de.4260285883: reply ok 240 lookup [|nfs]
21:10:17.212841 buruk.fokus.gmd.de.4277063099 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.213076 armada.nfs > buruk.fokus.gmd.de.4277063099: reply ok 240 lookup [|nfs]
21:10:17.213111 buruk.fokus.gmd.de.4293840315 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.213343 armada.nfs > buruk.fokus.gmd.de.4293840315: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.213372 buruk.fokus.gmd.de.15715771 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.213645 armada.nfs > buruk.fokus.gmd.de.15715771: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.213675 buruk.fokus.gmd.de.32492987 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.213937 armada.nfs > buruk.fokus.gmd.de.32492987: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.214005 buruk.fokus.gmd.de.49270203 > armada.nfs: 148 lookup [|nfs] (DF)
21:10:17.214236 armada.nfs > buruk.fokus.gmd.de.49270203: reply ok 116 lookup ERROR: No such file or directory
21:10:17.214277 buruk.fokus.gmd.de.66047419 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.214553 armada.nfs > buruk.fokus.gmd.de.66047419: reply ok 240 lookup [|nfs]
21:10:17.214594 buruk.fokus.gmd.de.82824635 > armada.nfs: 148 lookup [|nfs] (DF)
21:10:17.214826 armada.nfs > buruk.fokus.gmd.de.82824635: reply ok 116 lookup ERROR: No such file or directory
21:10:17.214885 buruk.fokus.gmd.de.99601851 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.215139 armada.nfs > buruk.fokus.gmd.de.99601851: reply ok 240 lookup [|nfs]
21:10:17.215178 buruk.fokus.gmd.de.116379067 > armada.nfs: 148 lookup [|nfs] (DF)
21:10:17.215412 armada.nfs > buruk.fokus.gmd.de.116379067: reply ok 116 lookup ERROR: No such file or directory
21:10:17.228459 buruk.fokus.gmd.de.133156283 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.228739 armada.nfs > buruk.fokus.gmd.de.133156283: reply ok 240 lookup [|nfs]
21:10:17.228821 buruk.fokus.gmd.de.149933499 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.229127 armada.nfs > buruk.fokus.gmd.de.149933499: reply ok 240 lookup [|nfs]
21:10:17.229167 buruk.fokus.gmd.de.166710715 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.229394 armada.nfs > buruk.fokus.gmd.de.166710715: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.229426 buruk.fokus.gmd.de.183487931 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.229686 armada.nfs > buruk.fokus.gmd.de.183487931: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.229717 buruk.fokus.gmd.de.200265147 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.229985 armada.nfs > buruk.fokus.gmd.de.200265147: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.230014 buruk.fokus.gmd.de.217042363 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.230276 armada.nfs > buruk.fokus.gmd.de.217042363: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.230309 buruk.fokus.gmd.de.233819579 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.230575 armada.nfs > buruk.fokus.gmd.de.233819579: reply ok 116 lookup ERROR: No such file or directory
21:10:17.230616 buruk.fokus.gmd.de.250596795 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.230892 armada.nfs > buruk.fokus.gmd.de.250596795: reply ok 240 lookup [|nfs]
21:10:17.230935 buruk.fokus.gmd.de.267374011 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.231190 armada.nfs > buruk.fokus.gmd.de.267374011: reply ok 240 lookup [|nfs]
21:10:17.231224 buruk.fokus.gmd.de.284151227 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.231457 armada.nfs > buruk.fokus.gmd.de.284151227: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.231485 buruk.fokus.gmd.de.300928443 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.231750 armada.nfs > buruk.fokus.gmd.de.300928443: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.231779 buruk.fokus.gmd.de.317705659 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.232048 armada.nfs > buruk.fokus.gmd.de.317705659: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.232076 buruk.fokus.gmd.de.334482875 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.232340 armada.nfs > buruk.fokus.gmd.de.334482875: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.232370 buruk.fokus.gmd.de.351260091 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.232638 armada.nfs > buruk.fokus.gmd.de.351260091: reply ok 116 lookup ERROR: No such file or directory
21:10:17.232677 buruk.fokus.gmd.de.368037307 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.232956 armada.nfs > buruk.fokus.gmd.de.368037307: reply ok 240 lookup [|nfs]
21:10:17.232999 buruk.fokus.gmd.de.384814523 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.233249 armada.nfs > buruk.fokus.gmd.de.384814523: reply ok 240 lookup [|nfs]
21:10:17.233283 buruk.fokus.gmd.de.401591739 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.233521 armada.nfs > buruk.fokus.gmd.de.401591739: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.233549 buruk.fokus.gmd.de.418368955 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.233819 armada.nfs > buruk.fokus.gmd.de.418368955: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.233851 buruk.fokus.gmd.de.435146171 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.234111 armada.nfs > buruk.fokus.gmd.de.435146171: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.234140 buruk.fokus.gmd.de.451923387 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.234409 armada.nfs > buruk.fokus.gmd.de.451923387: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.234439 buruk.fokus.gmd.de.468700603 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.234702 armada.nfs > buruk.fokus.gmd.de.468700603: reply ok 116 lookup ERROR: No such file or directory
21:10:17.234741 buruk.fokus.gmd.de.485477819 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.235112 armada.nfs > buruk.fokus.gmd.de.485477819: reply ok 240 lookup [|nfs]
21:10:17.235155 buruk.fokus.gmd.de.502255035 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.235419 armada.nfs > buruk.fokus.gmd.de.502255035: reply ok 240 lookup [|nfs]
21:10:17.235452 buruk.fokus.gmd.de.519032251 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.235686 armada.nfs > buruk.fokus.gmd.de.519032251: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.235714 buruk.fokus.gmd.de.535809467 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.235981 armada.nfs > buruk.fokus.gmd.de.535809467: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.236126 buruk.fokus.gmd.de.552586683 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.236372 armada.nfs > buruk.fokus.gmd.de.552586683: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.236402 buruk.fokus.gmd.de.569363899 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.236666 armada.nfs > buruk.fokus.gmd.de.569363899: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.236696 buruk.fokus.gmd.de.586141115 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.236974 armada.nfs > buruk.fokus.gmd.de.586141115: reply ok 116 lookup ERROR: No such file or directory
21:10:17.237015 buruk.fokus.gmd.de.602918331 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.237281 armada.nfs > buruk.fokus.gmd.de.602918331: reply ok 240 lookup [|nfs]
21:10:17.237323 buruk.fokus.gmd.de.619695547 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.237578 armada.nfs > buruk.fokus.gmd.de.619695547: reply ok 240 lookup [|nfs]
21:10:17.237613 buruk.fokus.gmd.de.636472763 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.237846 armada.nfs > buruk.fokus.gmd.de.636472763: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.237873 buruk.fokus.gmd.de.653249979 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.238138 armada.nfs > buruk.fokus.gmd.de.653249979: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.238166 buruk.fokus.gmd.de.670027195 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.238431 armada.nfs > buruk.fokus.gmd.de.670027195: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.238459 buruk.fokus.gmd.de.686804411 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.238729 armada.nfs > buruk.fokus.gmd.de.686804411: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.238760 buruk.fokus.gmd.de.703581627 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.239032 armada.nfs > buruk.fokus.gmd.de.703581627: reply ok 116 lookup ERROR: No such file or directory
21:10:17.239070 buruk.fokus.gmd.de.720358843 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.239345 armada.nfs > buruk.fokus.gmd.de.720358843: reply ok 240 lookup [|nfs]
21:10:17.239386 buruk.fokus.gmd.de.737136059 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.239642 armada.nfs > buruk.fokus.gmd.de.737136059: reply ok 240 lookup [|nfs]
21:10:17.239675 buruk.fokus.gmd.de.753913275 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.239914 armada.nfs > buruk.fokus.gmd.de.753913275: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.240102 buruk.fokus.gmd.de.770690491 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.240303 armada.nfs > buruk.fokus.gmd.de.770690491: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.240334 buruk.fokus.gmd.de.787467707 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.240596 armada.nfs > buruk.fokus.gmd.de.787467707: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.240629 buruk.fokus.gmd.de.804244923 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.240889 armada.nfs > buruk.fokus.gmd.de.804244923: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.240920 buruk.fokus.gmd.de.821022139 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.241192 armada.nfs > buruk.fokus.gmd.de.821022139: reply ok 116 lookup ERROR: No such file or directory
21:10:17.241237 buruk.fokus.gmd.de.837799355 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.241510 armada.nfs > buruk.fokus.gmd.de.837799355: reply ok 240 lookup [|nfs]
21:10:17.241555 buruk.fokus.gmd.de.854576571 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.241807 armada.nfs > buruk.fokus.gmd.de.854576571: reply ok 240 lookup [|nfs]
21:10:17.241842 buruk.fokus.gmd.de.871353787 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.242074 armada.nfs > buruk.fokus.gmd.de.871353787: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.242102 buruk.fokus.gmd.de.888131003 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.242368 armada.nfs > buruk.fokus.gmd.de.888131003: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.242396 buruk.fokus.gmd.de.904908219 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.242665 armada.nfs > buruk.fokus.gmd.de.904908219: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.242693 buruk.fokus.gmd.de.921685435 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.242957 armada.nfs > buruk.fokus.gmd.de.921685435: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.242989 buruk.fokus.gmd.de.938462651 > armada.nfs: 148 lookup [|nfs] (DF)
21:10:17.243255 armada.nfs > buruk.fokus.gmd.de.938462651: reply ok 116 lookup ERROR: No such file or directory
21:10:17.243294 buruk.fokus.gmd.de.955239867 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.243573 armada.nfs > buruk.fokus.gmd.de.955239867: reply ok 240 lookup [|nfs]
21:10:17.243614 buruk.fokus.gmd.de.972017083 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.243866 armada.nfs > buruk.fokus.gmd.de.972017083: reply ok 240 lookup [|nfs]
21:10:17.243900 buruk.fokus.gmd.de.988794299 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.244138 armada.nfs > buruk.fokus.gmd.de.988794299: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.244167 buruk.fokus.gmd.de.1005571515 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.244435 armada.nfs > buruk.fokus.gmd.de.1005571515: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.244464 buruk.fokus.gmd.de.1022348731 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.244729 armada.nfs > buruk.fokus.gmd.de.1022348731: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.244757 buruk.fokus.gmd.de.1039125947 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.245026 armada.nfs > buruk.fokus.gmd.de.1039125947: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.245068 buruk.fokus.gmd.de.1055903163 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.245345 armada.nfs > buruk.fokus.gmd.de.1055903163: reply ok 240 lookup [|nfs]
21:10:17.245380 buruk.fokus.gmd.de.1072680379 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.245612 armada.nfs > buruk.fokus.gmd.de.1072680379: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.245643 buruk.fokus.gmd.de.1089457595 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.245926 armada.nfs > buruk.fokus.gmd.de.1089457595: reply ok 116 lookup ERROR: No such file or directory
21:10:17.246154 buruk.fokus.gmd.de.1106234811 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.246430 armada.nfs > buruk.fokus.gmd.de.1106234811: reply ok 240 lookup [|nfs]
21:10:17.246466 buruk.fokus.gmd.de.1123012027 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.246697 armada.nfs > buruk.fokus.gmd.de.1123012027: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.246727 buruk.fokus.gmd.de.1139789243 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.246996 armada.nfs > buruk.fokus.gmd.de.1139789243: reply ok 116 lookup ERROR: No such file or directory
21:10:17.247075 buruk.fokus.gmd.de.1156566459 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.247312 armada.nfs > buruk.fokus.gmd.de.1156566459: reply ok 240 lookup [|nfs]
21:10:17.247347 buruk.fokus.gmd.de.1173343675 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.247580 armada.nfs > buruk.fokus.gmd.de.1173343675: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.247610 buruk.fokus.gmd.de.1190120891 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.247878 armada.nfs > buruk.fokus.gmd.de.1190120891: reply ok 116 lookup ERROR: No such file or directory
21:10:17.247916 buruk.fokus.gmd.de.1206898107 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.248201 armada.nfs > buruk.fokus.gmd.de.1206898107: reply ok 240 lookup [|nfs]
21:10:17.248236 buruk.fokus.gmd.de.1223675323 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.248468 armada.nfs > buruk.fokus.gmd.de.1223675323: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.248497 buruk.fokus.gmd.de.1240452539 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.248766 armada.nfs > buruk.fokus.gmd.de.1240452539: reply ok 116 lookup ERROR: No such file or directory
21:10:17.248804 buruk.fokus.gmd.de.1257229755 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.249085 armada.nfs > buruk.fokus.gmd.de.1257229755: reply ok 240 lookup [|nfs]
21:10:17.249119 buruk.fokus.gmd.de.1274006971 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.249351 armada.nfs > buruk.fokus.gmd.de.1274006971: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.249382 buruk.fokus.gmd.de.1290784187 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.249654 armada.nfs > buruk.fokus.gmd.de.1290784187: reply ok 116 lookup ERROR: No such file or directory
21:10:17.249692 buruk.fokus.gmd.de.1307561403 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.249978 armada.nfs > buruk.fokus.gmd.de.1307561403: reply ok 240 lookup [|nfs]
21:10:17.250014 buruk.fokus.gmd.de.1324338619 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.250239 armada.nfs > buruk.fokus.gmd.de.1324338619: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.250268 buruk.fokus.gmd.de.1341115835 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.250590 armada.nfs > buruk.fokus.gmd.de.1341115835: reply ok 116 lookup ERROR: No such file or directory
21:10:17.250628 buruk.fokus.gmd.de.1357893051 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.250855 armada.nfs > buruk.fokus.gmd.de.1357893051: reply ok 240 lookup [|nfs]
21:10:17.250889 buruk.fokus.gmd.de.1374670267 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.251127 armada.nfs > buruk.fokus.gmd.de.1374670267: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.251156 buruk.fokus.gmd.de.1391447483 > armada.nfs: 148 lookup [|nfs] (DF)
21:10:17.251420 armada.nfs > buruk.fokus.gmd.de.1391447483: reply ok 116 lookup ERROR: No such file or directory
21:10:17.251458 buruk.fokus.gmd.de.1408224699 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.251743 armada.nfs > buruk.fokus.gmd.de.1408224699: reply ok 240 lookup [|nfs]
21:10:17.251777 buruk.fokus.gmd.de.1425001915 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.252010 armada.nfs > buruk.fokus.gmd.de.1425001915: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.252195 buruk.fokus.gmd.de.1441779131 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.252429 armada.nfs > buruk.fokus.gmd.de.1441779131: reply ok 240 lookup [|nfs]
21:10:17.252466 buruk.fokus.gmd.de.1458556347 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.252696 armada.nfs > buruk.fokus.gmd.de.1458556347: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.252728 buruk.fokus.gmd.de.1475333563 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.252995 armada.nfs > buruk.fokus.gmd.de.1475333563: reply ok 116 lookup ERROR: No such file or directory
21:10:17.253033 buruk.fokus.gmd.de.1492110779 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.253312 armada.nfs > buruk.fokus.gmd.de.1492110779: reply ok 240 lookup [|nfs]
21:10:17.253345 buruk.fokus.gmd.de.1508887995 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.253584 armada.nfs > buruk.fokus.gmd.de.1508887995: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.253643 buruk.fokus.gmd.de.1525665211 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.253878 armada.nfs > buruk.fokus.gmd.de.1525665211: reply ok 116 lookup ERROR: No such file or directory
21:10:17.253918 buruk.fokus.gmd.de.1542442427 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.254200 armada.nfs > buruk.fokus.gmd.de.1542442427: reply ok 240 lookup [|nfs]
21:10:17.254235 buruk.fokus.gmd.de.1559219643 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.254467 armada.nfs > buruk.fokus.gmd.de.1559219643: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.254497 buruk.fokus.gmd.de.1575996859 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.254766 armada.nfs > buruk.fokus.gmd.de.1575996859: reply ok 116 lookup ERROR: No such file or directory
21:10:17.254804 buruk.fokus.gmd.de.1592774075 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.255083 armada.nfs > buruk.fokus.gmd.de.1592774075: reply ok 240 lookup [|nfs]
21:10:17.255116 buruk.fokus.gmd.de.1609551291 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.255355 armada.nfs > buruk.fokus.gmd.de.1609551291: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.255385 buruk.fokus.gmd.de.1626328507 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.255649 armada.nfs > buruk.fokus.gmd.de.1626328507: reply ok 116 lookup ERROR: No such file or directory
21:10:17.255687 buruk.fokus.gmd.de.1643105723 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.255981 armada.nfs > buruk.fokus.gmd.de.1643105723: reply ok 240 lookup [|nfs]
21:10:17.257238 buruk.fokus.gmd.de.1659882939 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.257519 armada.nfs > buruk.fokus.gmd.de.1659882939: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.257574 buruk.fokus.gmd.de.1676660155 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.257814 armada.nfs > buruk.fokus.gmd.de.1676660155: reply ok 116 lookup ERROR: No such file or directory
21:10:17.257873 buruk.fokus.gmd.de.1693437371 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.258204 armada.nfs > buruk.fokus.gmd.de.1693437371: reply ok 240 lookup [|nfs]
21:10:17.258240 buruk.fokus.gmd.de.1710214587 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.258500 armada.nfs > buruk.fokus.gmd.de.1710214587: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.258530 buruk.fokus.gmd.de.1726991803 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.258798 armada.nfs > buruk.fokus.gmd.de.1726991803: reply ok 116 lookup ERROR: No such file or directory
21:10:17.258841 buruk.fokus.gmd.de.1743769019 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.259121 armada.nfs > buruk.fokus.gmd.de.1743769019: reply ok 240 lookup [|nfs]
21:10:17.259155 buruk.fokus.gmd.de.1760546235 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.259388 armada.nfs > buruk.fokus.gmd.de.1760546235: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.259419 buruk.fokus.gmd.de.1777323451 > armada.nfs: 148 lookup [|nfs] (DF)
21:10:17.259686 armada.nfs > buruk.fokus.gmd.de.1777323451: reply ok 116 lookup ERROR: No such file or directory
21:10:17.259724 buruk.fokus.gmd.de.1794100667 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.260004 armada.nfs > buruk.fokus.gmd.de.1794100667: reply ok 240 lookup [|nfs]
21:10:17.260039 buruk.fokus.gmd.de.1810877883 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.260271 armada.nfs > buruk.fokus.gmd.de.1810877883: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.262428 buruk.fokus.gmd.de.1827655099 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.262746 armada.nfs > buruk.fokus.gmd.de.1827655099: reply ok 240 lookup [|nfs]
21:10:17.262827 buruk.fokus.gmd.de.1844432315 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.263133 armada.nfs > buruk.fokus.gmd.de.1844432315: reply ok 240 lookup [|nfs]
21:10:17.263347 buruk.fokus.gmd.de.1861209531 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.263599 armada.nfs > buruk.fokus.gmd.de.1861209531: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.263634 buruk.fokus.gmd.de.1877986747 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.263895 armada.nfs > buruk.fokus.gmd.de.1877986747: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.263926 buruk.fokus.gmd.de.1894763963 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.264188 armada.nfs > buruk.fokus.gmd.de.1894763963: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.264228 buruk.fokus.gmd.de.1911541179 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.264486 armada.nfs > buruk.fokus.gmd.de.1911541179: reply ok 116 lookup ERROR: No such file or directory
21:10:17.264533 buruk.fokus.gmd.de.1928318395 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.264804 armada.nfs > buruk.fokus.gmd.de.1928318395: reply ok 240 lookup [|nfs]
21:10:17.264851 buruk.fokus.gmd.de.1945095611 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.265101 armada.nfs > buruk.fokus.gmd.de.1945095611: reply ok 240 lookup [|nfs]
21:10:17.265137 buruk.fokus.gmd.de.1961872827 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.265368 armada.nfs > buruk.fokus.gmd.de.1961872827: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.265397 buruk.fokus.gmd.de.1978650043 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.265661 armada.nfs > buruk.fokus.gmd.de.1978650043: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.265690 buruk.fokus.gmd.de.1995427259 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.265960 armada.nfs > buruk.fokus.gmd.de.1995427259: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.266117 buruk.fokus.gmd.de.2012204475 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.266352 armada.nfs > buruk.fokus.gmd.de.2012204475: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.266384 buruk.fokus.gmd.de.2028981691 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.266646 armada.nfs > buruk.fokus.gmd.de.2028981691: reply ok 116 lookup ERROR: No such file or directory
21:10:17.266688 buruk.fokus.gmd.de.2045758907 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.266974 armada.nfs > buruk.fokus.gmd.de.2045758907: reply ok 240 lookup [|nfs]
21:10:17.267016 buruk.fokus.gmd.de.2062536123 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.267266 armada.nfs > buruk.fokus.gmd.de.2062536123: reply ok 240 lookup [|nfs]
21:10:17.267301 buruk.fokus.gmd.de.2079313339 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.267528 armada.nfs > buruk.fokus.gmd.de.2079313339: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.267557 buruk.fokus.gmd.de.2096090555 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.267826 armada.nfs > buruk.fokus.gmd.de.2096090555: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.267854 buruk.fokus.gmd.de.2112867771 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.268134 armada.nfs > buruk.fokus.gmd.de.2112867771: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.268162 buruk.fokus.gmd.de.2129644987 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.268416 armada.nfs > buruk.fokus.gmd.de.2129644987: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.268446 buruk.fokus.gmd.de.2146422203 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.268715 armada.nfs > buruk.fokus.gmd.de.2146422203: reply ok 116 lookup ERROR: No such file or directory
21:10:17.268753 buruk.fokus.gmd.de.2163199419 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.269038 armada.nfs > buruk.fokus.gmd.de.2163199419: reply ok 240 lookup [|nfs]
21:10:17.269079 buruk.fokus.gmd.de.2179976635 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.269330 armada.nfs > buruk.fokus.gmd.de.2179976635: reply ok 240 lookup [|nfs]
21:10:17.269364 buruk.fokus.gmd.de.2196753851 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.269592 armada.nfs > buruk.fokus.gmd.de.2196753851: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.269620 buruk.fokus.gmd.de.2213531067 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.269890 armada.nfs > buruk.fokus.gmd.de.2213531067: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.269918 buruk.fokus.gmd.de.2230308283 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.270182 armada.nfs > buruk.fokus.gmd.de.2230308283: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.270211 buruk.fokus.gmd.de.2247085499 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.270480 armada.nfs > buruk.fokus.gmd.de.2247085499: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.270547 buruk.fokus.gmd.de.2263862715 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.270783 armada.nfs > buruk.fokus.gmd.de.2263862715: reply ok 116 lookup ERROR: No such file or directory
21:10:17.270823 buruk.fokus.gmd.de.2280639931 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.271096 armada.nfs > buruk.fokus.gmd.de.2280639931: reply ok 240 lookup [|nfs]
21:10:17.271139 buruk.fokus.gmd.de.2297417147 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.271394 armada.nfs > buruk.fokus.gmd.de.2297417147: reply ok 240 lookup [|nfs]
21:10:17.271428 buruk.fokus.gmd.de.2314194363 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.271661 armada.nfs > buruk.fokus.gmd.de.2314194363: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.271689 buruk.fokus.gmd.de.2330971579 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.271958 armada.nfs > buruk.fokus.gmd.de.2330971579: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.271987 buruk.fokus.gmd.de.2347748795 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.272251 armada.nfs > buruk.fokus.gmd.de.2347748795: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.272280 buruk.fokus.gmd.de.2364526011 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.272544 armada.nfs > buruk.fokus.gmd.de.2364526011: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.272576 buruk.fokus.gmd.de.2381303227 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.272842 armada.nfs > buruk.fokus.gmd.de.2381303227: reply ok 116 lookup ERROR: No such file or directory
21:10:17.272881 buruk.fokus.gmd.de.2398080443 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.273165 armada.nfs > buruk.fokus.gmd.de.2398080443: reply ok 240 lookup [|nfs]
21:10:17.273206 buruk.fokus.gmd.de.2414857659 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.273457 armada.nfs > buruk.fokus.gmd.de.2414857659: reply ok 240 lookup [|nfs]
21:10:17.273492 buruk.fokus.gmd.de.2431634875 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.273729 armada.nfs > buruk.fokus.gmd.de.2431634875: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.273757 buruk.fokus.gmd.de.2448412091 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.274023 armada.nfs > buruk.fokus.gmd.de.2448412091: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.274051 buruk.fokus.gmd.de.2465189307 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.274320 armada.nfs > buruk.fokus.gmd.de.2465189307: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.274348 buruk.fokus.gmd.de.2481966523 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.274612 armada.nfs > buruk.fokus.gmd.de.2481966523: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.274643 buruk.fokus.gmd.de.2498743739 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.274911 armada.nfs > buruk.fokus.gmd.de.2498743739: reply ok 116 lookup ERROR: No such file or directory
21:10:17.274949 buruk.fokus.gmd.de.2515520955 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.275228 armada.nfs > buruk.fokus.gmd.de.2515520955: reply ok 240 lookup [|nfs]
21:10:17.275270 buruk.fokus.gmd.de.2532298171 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.275526 armada.nfs > buruk.fokus.gmd.de.2532298171: reply ok 240 lookup [|nfs]
21:10:17.275560 buruk.fokus.gmd.de.2549075387 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.275794 armada.nfs > buruk.fokus.gmd.de.2549075387: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.275821 buruk.fokus.gmd.de.2565852603 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.276087 armada.nfs > buruk.fokus.gmd.de.2565852603: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.277133 buruk.fokus.gmd.de.2582629819 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.277356 armada.nfs > buruk.fokus.gmd.de.2582629819: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.277401 buruk.fokus.gmd.de.2599407035 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.277652 armada.nfs > buruk.fokus.gmd.de.2599407035: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.277690 buruk.fokus.gmd.de.2616184251 > armada.nfs: 148 lookup [|nfs] (DF)
21:10:17.277950 armada.nfs > buruk.fokus.gmd.de.2616184251: reply ok 116 lookup ERROR: No such file or directory
21:10:17.278079 buruk.fokus.gmd.de.2632961467 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.278368 armada.nfs > buruk.fokus.gmd.de.2632961467: reply ok 240 lookup [|nfs]
21:10:17.278424 buruk.fokus.gmd.de.2649738683 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.278662 armada.nfs > buruk.fokus.gmd.de.2649738683: reply ok 240 lookup [|nfs]
21:10:17.278700 buruk.fokus.gmd.de.2666515899 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.278928 armada.nfs > buruk.fokus.gmd.de.2666515899: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.278957 buruk.fokus.gmd.de.2683293115 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.279226 armada.nfs > buruk.fokus.gmd.de.2683293115: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.279254 buruk.fokus.gmd.de.2700070331 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.279519 armada.nfs > buruk.fokus.gmd.de.2700070331: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.279546 buruk.fokus.gmd.de.2716847547 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.279834 armada.nfs > buruk.fokus.gmd.de.2716847547: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.279878 buruk.fokus.gmd.de.2733624763 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.280134 armada.nfs > buruk.fokus.gmd.de.2733624763: reply ok 240 lookup [|nfs]
21:10:17.280175 buruk.fokus.gmd.de.2750401979 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.280407 armada.nfs > buruk.fokus.gmd.de.2750401979: reply ok 116 lookup ERROR: No such file or directory
21:10:17.280446 buruk.fokus.gmd.de.2767179195 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.280725 armada.nfs > buruk.fokus.gmd.de.2767179195: reply ok 240 lookup [|nfs]
21:10:17.280759 buruk.fokus.gmd.de.2783956411 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.280992 armada.nfs > buruk.fokus.gmd.de.2783956411: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.281022 buruk.fokus.gmd.de.2800733627 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.281291 armada.nfs > buruk.fokus.gmd.de.2800733627: reply ok 116 lookup ERROR: No such file or directory
21:10:17.281330 buruk.fokus.gmd.de.2817510843 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.281608 armada.nfs > buruk.fokus.gmd.de.2817510843: reply ok 240 lookup [|nfs]
21:10:17.281642 buruk.fokus.gmd.de.2834288059 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.281880 armada.nfs > buruk.fokus.gmd.de.2834288059: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.281910 buruk.fokus.gmd.de.2851065275 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.282174 armada.nfs > buruk.fokus.gmd.de.2851065275: reply ok 116 lookup ERROR: No such file or directory
21:10:17.282211 buruk.fokus.gmd.de.2867842491 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.282496 armada.nfs > buruk.fokus.gmd.de.2867842491: reply ok 240 lookup [|nfs]
21:10:17.282531 buruk.fokus.gmd.de.2884619707 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.282763 armada.nfs > buruk.fokus.gmd.de.2884619707: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.282793 buruk.fokus.gmd.de.2901396923 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.283066 armada.nfs > buruk.fokus.gmd.de.2901396923: reply ok 116 lookup ERROR: No such file or directory
21:10:17.283104 buruk.fokus.gmd.de.2918174139 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.283379 armada.nfs > buruk.fokus.gmd.de.2918174139: reply ok 240 lookup [|nfs]
21:10:17.283413 buruk.fokus.gmd.de.2934951355 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.283648 armada.nfs > buruk.fokus.gmd.de.2934951355: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.283678 buruk.fokus.gmd.de.2951728571 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.283945 armada.nfs > buruk.fokus.gmd.de.2951728571: reply ok 116 lookup ERROR: No such file or directory
21:10:17.283982 buruk.fokus.gmd.de.2968505787 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.284262 armada.nfs > buruk.fokus.gmd.de.2968505787: reply ok 240 lookup [|nfs]
21:10:17.284297 buruk.fokus.gmd.de.2985283003 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.284530 armada.nfs > buruk.fokus.gmd.de.2985283003: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.284603 buruk.fokus.gmd.de.3002060219 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.284829 armada.nfs > buruk.fokus.gmd.de.3002060219: reply ok 116 lookup ERROR: No such file or directory
21:10:17.284869 buruk.fokus.gmd.de.3018837435 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.285150 armada.nfs > buruk.fokus.gmd.de.3018837435: reply ok 240 lookup [|nfs]
21:10:17.285186 buruk.fokus.gmd.de.3035614651 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.285417 armada.nfs > buruk.fokus.gmd.de.3035614651: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.285448 buruk.fokus.gmd.de.3052391867 > armada.nfs: 148 lookup [|nfs] (DF)
21:10:17.285865 armada.nfs > buruk.fokus.gmd.de.3052391867: reply ok 116 lookup ERROR: No such file or directory
21:10:17.285924 buruk.fokus.gmd.de.3069169083 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.286236 armada.nfs > buruk.fokus.gmd.de.3069169083: reply ok 240 lookup [|nfs]
21:10:17.287828 buruk.fokus.gmd.de.3085946299 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.288064 armada.nfs > buruk.fokus.gmd.de.3085946299: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.288286 buruk.fokus.gmd.de.3102723515 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.288583 armada.nfs > buruk.fokus.gmd.de.3102723515: reply ok 240 lookup [|nfs]
21:10:17.288628 buruk.fokus.gmd.de.3119500731 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.288855 armada.nfs > buruk.fokus.gmd.de.3119500731: reply ok 116 lookup ERROR: No such file or directory
21:10:17.288896 buruk.fokus.gmd.de.3136277947 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.289173 armada.nfs > buruk.fokus.gmd.de.3136277947: reply ok 240 lookup [|nfs]
21:10:17.289208 buruk.fokus.gmd.de.3153055163 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.289440 armada.nfs > buruk.fokus.gmd.de.3153055163: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.289471 buruk.fokus.gmd.de.3169832379 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.289738 armada.nfs > buruk.fokus.gmd.de.3169832379: reply ok 116 lookup ERROR: No such file or directory
21:10:17.289777 buruk.fokus.gmd.de.3186609595 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.290056 armada.nfs > buruk.fokus.gmd.de.3186609595: reply ok 240 lookup [|nfs]
21:10:17.290091 buruk.fokus.gmd.de.3203386811 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.290573 armada.nfs > buruk.fokus.gmd.de.3203386811: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.290603 buruk.fokus.gmd.de.3220164027 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.290828 armada.nfs > buruk.fokus.gmd.de.3220164027: reply ok 116 lookup ERROR: No such file or directory
21:10:17.290867 buruk.fokus.gmd.de.3236941243 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.291140 armada.nfs > buruk.fokus.gmd.de.3236941243: reply ok 240 lookup [|nfs]
21:10:17.291176 buruk.fokus.gmd.de.3253718459 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.291413 armada.nfs > buruk.fokus.gmd.de.3253718459: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.291443 buruk.fokus.gmd.de.3270495675 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.291706 armada.nfs > buruk.fokus.gmd.de.3270495675: reply ok 116 lookup ERROR: No such file or directory
21:10:17.291746 buruk.fokus.gmd.de.3287272891 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.292030 armada.nfs > buruk.fokus.gmd.de.3287272891: reply ok 240 lookup [|nfs]
21:10:17.292064 buruk.fokus.gmd.de.3304050107 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.292291 armada.nfs > buruk.fokus.gmd.de.3304050107: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.292322 buruk.fokus.gmd.de.3320827323 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.292589 armada.nfs > buruk.fokus.gmd.de.3320827323: reply ok 116 lookup ERROR: No such file or directory
21:10:17.292628 buruk.fokus.gmd.de.3337604539 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.292907 armada.nfs > buruk.fokus.gmd.de.3337604539: reply ok 240 lookup [|nfs]
21:10:17.292941 buruk.fokus.gmd.de.3354381755 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.293179 armada.nfs > buruk.fokus.gmd.de.3354381755: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.293282 buruk.fokus.gmd.de.3371158971 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.293477 armada.nfs > buruk.fokus.gmd.de.3371158971: reply ok 116 lookup ERROR: No such file or directory
21:10:17.293517 buruk.fokus.gmd.de.3387936187 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.293790 armada.nfs > buruk.fokus.gmd.de.3387936187: reply ok 240 lookup [|nfs]
21:10:17.293825 buruk.fokus.gmd.de.3404713403 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.294062 armada.nfs > buruk.fokus.gmd.de.3404713403: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.294093 buruk.fokus.gmd.de.3421490619 > armada.nfs: 148 lookup [|nfs] (DF)
21:10:17.294360 armada.nfs > buruk.fokus.gmd.de.3421490619: reply ok 116 lookup ERROR: No such file or directory
21:10:17.294399 buruk.fokus.gmd.de.3438267835 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.294678 armada.nfs > buruk.fokus.gmd.de.3438267835: reply ok 240 lookup [|nfs]
21:10:17.294713 buruk.fokus.gmd.de.3455045051 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.294941 armada.nfs > buruk.fokus.gmd.de.3455045051: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.295861 buruk.fokus.gmd.de.3471822267 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.296187 armada.nfs > buruk.fokus.gmd.de.3471822267: reply ok 240 lookup [|nfs]
21:10:17.296323 buruk.fokus.gmd.de.3488599483 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.296550 armada.nfs > buruk.fokus.gmd.de.3488599483: reply ok 240 lookup [|nfs]
21:10:17.296609 buruk.fokus.gmd.de.3505376699 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.296833 armada.nfs > buruk.fokus.gmd.de.3505376699: reply ok 240 lookup [|nfs]
21:10:17.296872 buruk.fokus.gmd.de.3522153915 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.297110 armada.nfs > buruk.fokus.gmd.de.3522153915: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.297141 buruk.fokus.gmd.de.3538931131 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.297407 armada.nfs > buruk.fokus.gmd.de.3538931131: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.297439 buruk.fokus.gmd.de.3555708347 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.297701 armada.nfs > buruk.fokus.gmd.de.3555708347: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.297748 buruk.fokus.gmd.de.3572485563 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.298028 armada.nfs > buruk.fokus.gmd.de.3572485563: reply ok 240 lookup [|nfs]
21:10:17.298989 buruk.fokus.gmd.de.3589262779 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.299298 armada.nfs > buruk.fokus.gmd.de.3589262779: reply ok 240 lookup [|nfs]
21:10:17.299369 buruk.fokus.gmd.de.3606039995 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.299588 armada.nfs > buruk.fokus.gmd.de.3606039995: reply ok 240 lookup [|nfs]
21:10:17.299627 buruk.fokus.gmd.de.3622817211 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.299856 armada.nfs > buruk.fokus.gmd.de.3622817211: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.299888 buruk.fokus.gmd.de.3639594427 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.300154 armada.nfs > buruk.fokus.gmd.de.3639594427: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.300185 buruk.fokus.gmd.de.3656371643 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.300450 armada.nfs > buruk.fokus.gmd.de.3656371643: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.300487 buruk.fokus.gmd.de.3673148859 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.300749 armada.nfs > buruk.fokus.gmd.de.3673148859: reply ok 116 lookup ERROR: No such file or directory
21:10:17.300791 buruk.fokus.gmd.de.3689926075 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.301067 armada.nfs > buruk.fokus.gmd.de.3689926075: reply ok 240 lookup [|nfs]
21:10:17.301110 buruk.fokus.gmd.de.3706703291 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.301354 armada.nfs > buruk.fokus.gmd.de.3706703291: reply ok 240 lookup [|nfs]
21:10:17.301389 buruk.fokus.gmd.de.3723480507 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.301626 armada.nfs > buruk.fokus.gmd.de.3723480507: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.301719 buruk.fokus.gmd.de.3740257723 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.301924 armada.nfs > buruk.fokus.gmd.de.3740257723: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.301954 buruk.fokus.gmd.de.3757034939 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.302222 armada.nfs > buruk.fokus.gmd.de.3757034939: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.302250 buruk.fokus.gmd.de.3773812155 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.302515 armada.nfs > buruk.fokus.gmd.de.3773812155: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.302546 buruk.fokus.gmd.de.3790589371 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.302813 armada.nfs > buruk.fokus.gmd.de.3790589371: reply ok 116 lookup ERROR: No such file or directory
21:10:17.302851 buruk.fokus.gmd.de.3807366587 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.303131 armada.nfs > buruk.fokus.gmd.de.3807366587: reply ok 240 lookup [|nfs]
21:10:17.303175 buruk.fokus.gmd.de.3824143803 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.303428 armada.nfs > buruk.fokus.gmd.de.3824143803: reply ok 240 lookup [|nfs]
21:10:17.303463 buruk.fokus.gmd.de.3840921019 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.303700 armada.nfs > buruk.fokus.gmd.de.3840921019: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.303728 buruk.fokus.gmd.de.3857698235 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.303993 armada.nfs > buruk.fokus.gmd.de.3857698235: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.304021 buruk.fokus.gmd.de.3874475451 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.304286 armada.nfs > buruk.fokus.gmd.de.3874475451: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.304314 buruk.fokus.gmd.de.3891252667 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.304578 armada.nfs > buruk.fokus.gmd.de.3891252667: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.304608 buruk.fokus.gmd.de.3908029883 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.304876 armada.nfs > buruk.fokus.gmd.de.3908029883: reply ok 116 lookup ERROR: No such file or directory
21:10:17.304915 buruk.fokus.gmd.de.3924807099 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.305194 armada.nfs > buruk.fokus.gmd.de.3924807099: reply ok 240 lookup [|nfs]
21:10:17.305235 buruk.fokus.gmd.de.3941584315 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.305511 armada.nfs > buruk.fokus.gmd.de.3941584315: reply ok 240 lookup [|nfs]
21:10:17.305545 buruk.fokus.gmd.de.3958361531 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.305759 armada.nfs > buruk.fokus.gmd.de.3958361531: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.305787 buruk.fokus.gmd.de.3975138747 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.306053 armada.nfs > buruk.fokus.gmd.de.3975138747: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.306212 buruk.fokus.gmd.de.3991915963 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.306446 armada.nfs > buruk.fokus.gmd.de.3991915963: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.306476 buruk.fokus.gmd.de.4008693179 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.306742 armada.nfs > buruk.fokus.gmd.de.4008693179: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.306774 buruk.fokus.gmd.de.4025470395 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.307037 armada.nfs > buruk.fokus.gmd.de.4025470395: reply ok 116 lookup ERROR: No such file or directory
21:10:17.307079 buruk.fokus.gmd.de.4042247611 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.307359 armada.nfs > buruk.fokus.gmd.de.4042247611: reply ok 240 lookup [|nfs]
21:10:17.307402 buruk.fokus.gmd.de.4059024827 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.307657 armada.nfs > buruk.fokus.gmd.de.4059024827: reply ok 240 lookup [|nfs]
21:10:17.307690 buruk.fokus.gmd.de.4075802043 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.307924 armada.nfs > buruk.fokus.gmd.de.4075802043: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.307952 buruk.fokus.gmd.de.4092579259 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.308217 armada.nfs > buruk.fokus.gmd.de.4092579259: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.308290 buruk.fokus.gmd.de.4109356475 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.308514 armada.nfs > buruk.fokus.gmd.de.4109356475: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.308543 buruk.fokus.gmd.de.4126133691 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.308807 armada.nfs > buruk.fokus.gmd.de.4126133691: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.308838 buruk.fokus.gmd.de.4142910907 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.309110 armada.nfs > buruk.fokus.gmd.de.4142910907: reply ok 116 lookup ERROR: No such file or directory
21:10:17.309149 buruk.fokus.gmd.de.4159688123 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.309429 armada.nfs > buruk.fokus.gmd.de.4159688123: reply ok 240 lookup [|nfs]
21:10:17.309769 buruk.fokus.gmd.de.4176465339 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.310014 armada.nfs > buruk.fokus.gmd.de.4176465339: reply ok 240 lookup [|nfs]
21:10:17.310050 buruk.fokus.gmd.de.4193242555 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.310281 armada.nfs > buruk.fokus.gmd.de.4193242555: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.310309 buruk.fokus.gmd.de.4210019771 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.310579 armada.nfs > buruk.fokus.gmd.de.4210019771: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.310608 buruk.fokus.gmd.de.4226796987 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.310871 armada.nfs > buruk.fokus.gmd.de.4226796987: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.310899 buruk.fokus.gmd.de.4243574203 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.311164 armada.nfs > buruk.fokus.gmd.de.4243574203: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.311194 buruk.fokus.gmd.de.4260351419 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.311462 armada.nfs > buruk.fokus.gmd.de.4260351419: reply ok 116 lookup ERROR: No such file or directory
21:10:17.311503 buruk.fokus.gmd.de.4277128635 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.311784 armada.nfs > buruk.fokus.gmd.de.4277128635: reply ok 240 lookup [|nfs]
21:10:17.311827 buruk.fokus.gmd.de.4293905851 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.312077 armada.nfs > buruk.fokus.gmd.de.4293905851: reply ok 240 lookup [|nfs]
21:10:17.312112 buruk.fokus.gmd.de.15781307 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.312344 armada.nfs > buruk.fokus.gmd.de.15781307: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.312372 buruk.fokus.gmd.de.32558523 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.312637 armada.nfs > buruk.fokus.gmd.de.32558523: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.312665 buruk.fokus.gmd.de.49335739 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.312935 armada.nfs > buruk.fokus.gmd.de.49335739: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.312964 buruk.fokus.gmd.de.66112955 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.313232 armada.nfs > buruk.fokus.gmd.de.66112955: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.313263 buruk.fokus.gmd.de.82890171 > armada.nfs: 148 lookup [|nfs] (DF)
21:10:17.313531 armada.nfs > buruk.fokus.gmd.de.82890171: reply ok 116 lookup ERROR: No such file or directory
21:10:17.313569 buruk.fokus.gmd.de.99667387 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.313849 armada.nfs > buruk.fokus.gmd.de.99667387: reply ok 240 lookup [|nfs]
21:10:17.313891 buruk.fokus.gmd.de.116444603 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.314142 armada.nfs > buruk.fokus.gmd.de.116444603: reply ok 240 lookup [|nfs]
21:10:17.314176 buruk.fokus.gmd.de.133221819 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.314408 armada.nfs > buruk.fokus.gmd.de.133221819: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.314436 buruk.fokus.gmd.de.149999035 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.314701 armada.nfs > buruk.fokus.gmd.de.149999035: reply ok 112 getattr LNK 120777 ids 571/2000 [|nfs]
21:10:17.314729 buruk.fokus.gmd.de.166776251 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.314999 armada.nfs > buruk.fokus.gmd.de.166776251: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.315072 buruk.fokus.gmd.de.183553467 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.315297 armada.nfs > buruk.fokus.gmd.de.183553467: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.315340 buruk.fokus.gmd.de.200330683 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.315615 armada.nfs > buruk.fokus.gmd.de.200330683: reply ok 240 lookup [|nfs]
21:10:17.315654 buruk.fokus.gmd.de.217107899 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.315893 armada.nfs > buruk.fokus.gmd.de.217107899: reply ok 116 lookup ERROR: No such file or directory
21:10:17.316639 buruk.fokus.gmd.de.233885115 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.316893 armada.nfs > buruk.fokus.gmd.de.233885115: reply ok 240 lookup [|nfs]
21:10:17.316947 buruk.fokus.gmd.de.250662331 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.317159 armada.nfs > buruk.fokus.gmd.de.250662331: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.317195 buruk.fokus.gmd.de.267439547 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.317457 armada.nfs > buruk.fokus.gmd.de.267439547: reply ok 116 lookup ERROR: No such file or directory
21:10:17.317499 buruk.fokus.gmd.de.284216763 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.317775 armada.nfs > buruk.fokus.gmd.de.284216763: reply ok 240 lookup [|nfs]
21:10:17.317810 buruk.fokus.gmd.de.300993979 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.318075 armada.nfs > buruk.fokus.gmd.de.300993979: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.318105 buruk.fokus.gmd.de.317771195 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.318345 armada.nfs > buruk.fokus.gmd.de.317771195: reply ok 116 lookup ERROR: No such file or directory
21:10:17.318383 buruk.fokus.gmd.de.334548411 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.318668 armada.nfs > buruk.fokus.gmd.de.334548411: reply ok 240 lookup [|nfs]
21:10:17.318702 buruk.fokus.gmd.de.351325627 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.318926 armada.nfs > buruk.fokus.gmd.de.351325627: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.318955 buruk.fokus.gmd.de.368102843 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.319228 armada.nfs > buruk.fokus.gmd.de.368102843: reply ok 116 lookup ERROR: No such file or directory
21:10:17.319267 buruk.fokus.gmd.de.384880059 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.319551 armada.nfs > buruk.fokus.gmd.de.384880059: reply ok 240 lookup [|nfs]
21:10:17.319586 buruk.fokus.gmd.de.401657275 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.319818 armada.nfs > buruk.fokus.gmd.de.401657275: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.319848 buruk.fokus.gmd.de.418434491 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.320116 armada.nfs > buruk.fokus.gmd.de.418434491: reply ok 116 lookup ERROR: No such file or directory
21:10:17.320153 buruk.fokus.gmd.de.435211707 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.320429 armada.nfs > buruk.fokus.gmd.de.435211707: reply ok 240 lookup [|nfs]
21:10:17.320464 buruk.fokus.gmd.de.451988923 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.320701 armada.nfs > buruk.fokus.gmd.de.451988923: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.320731 buruk.fokus.gmd.de.468766139 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.320994 armada.nfs > buruk.fokus.gmd.de.468766139: reply ok 116 lookup ERROR: No such file or directory
21:10:17.321033 buruk.fokus.gmd.de.485543355 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.321317 armada.nfs > buruk.fokus.gmd.de.485543355: reply ok 240 lookup [|nfs]
21:10:17.321352 buruk.fokus.gmd.de.502320571 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.321584 armada.nfs > buruk.fokus.gmd.de.502320571: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.321614 buruk.fokus.gmd.de.519097787 > armada.nfs: 148 lookup [|nfs] (DF)
21:10:17.321887 armada.nfs > buruk.fokus.gmd.de.519097787: reply ok 116 lookup ERROR: No such file or directory
21:10:17.321925 buruk.fokus.gmd.de.535875003 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.322200 armada.nfs > buruk.fokus.gmd.de.535875003: reply ok 240 lookup [|nfs]
21:10:17.322301 buruk.fokus.gmd.de.552652219 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.322568 armada.nfs > buruk.fokus.gmd.de.552652219: reply ok 112 getattr DIR 42775 ids 571/2000 [|nfs]
21:10:17.322748 buruk.fokus.gmd.de.569429435 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.322987 armada.nfs > buruk.fokus.gmd.de.569429435: reply ok 240 lookup [|nfs]
21:10:17.323029 buruk.fokus.gmd.de.586206651 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.323260 armada.nfs > buruk.fokus.gmd.de.586206651: reply ok 116 lookup ERROR: No such file or directory
21:10:17.323298 buruk.fokus.gmd.de.602983867 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.323578 armada.nfs > buruk.fokus.gmd.de.602983867: reply ok 240 lookup [|nfs]
21:10:17.323612 buruk.fokus.gmd.de.619761083 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.323845 armada.nfs > buruk.fokus.gmd.de.619761083: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.323874 buruk.fokus.gmd.de.636538299 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.324172 armada.nfs > buruk.fokus.gmd.de.636538299: reply ok 116 lookup ERROR: No such file or directory
21:10:17.324210 buruk.fokus.gmd.de.653315515 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.324462 armada.nfs > buruk.fokus.gmd.de.653315515: reply ok 240 lookup [|nfs]
21:10:17.324496 buruk.fokus.gmd.de.670092731 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.324733 armada.nfs > buruk.fokus.gmd.de.670092731: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.324763 buruk.fokus.gmd.de.686869947 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.325031 armada.nfs > buruk.fokus.gmd.de.686869947: reply ok 116 lookup ERROR: No such file or directory
21:10:17.325069 buruk.fokus.gmd.de.703647163 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.325349 armada.nfs > buruk.fokus.gmd.de.703647163: reply ok 240 lookup [|nfs]
21:10:17.325383 buruk.fokus.gmd.de.720424379 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.325621 armada.nfs > buruk.fokus.gmd.de.720424379: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.325651 buruk.fokus.gmd.de.737201595 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.325929 armada.nfs > buruk.fokus.gmd.de.737201595: reply ok 116 lookup ERROR: No such file or directory
21:10:17.326161 buruk.fokus.gmd.de.753978811 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.326429 armada.nfs > buruk.fokus.gmd.de.753978811: reply ok 240 lookup [|nfs]
21:10:17.326465 buruk.fokus.gmd.de.770756027 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.326701 armada.nfs > buruk.fokus.gmd.de.770756027: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.326733 buruk.fokus.gmd.de.787533243 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.326995 armada.nfs > buruk.fokus.gmd.de.787533243: reply ok 116 lookup ERROR: No such file or directory
21:10:17.327034 buruk.fokus.gmd.de.804310459 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.327317 armada.nfs > buruk.fokus.gmd.de.804310459: reply ok 240 lookup [|nfs]
21:10:17.327351 buruk.fokus.gmd.de.821087675 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.327584 armada.nfs > buruk.fokus.gmd.de.821087675: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.327614 buruk.fokus.gmd.de.837864891 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.327882 armada.nfs > buruk.fokus.gmd.de.837864891: reply ok 116 lookup ERROR: No such file or directory
21:10:17.327921 buruk.fokus.gmd.de.854642107 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.328200 armada.nfs > buruk.fokus.gmd.de.854642107: reply ok 240 lookup [|nfs]
21:10:17.328235 buruk.fokus.gmd.de.871419323 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.328467 armada.nfs > buruk.fokus.gmd.de.871419323: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
21:10:17.328498 buruk.fokus.gmd.de.888196539 > armada.nfs: 148 lookup [|nfs] (DF)
21:10:17.328770 armada.nfs > buruk.fokus.gmd.de.888196539: reply ok 116 lookup ERROR: No such file or directory
21:10:17.328808 buruk.fokus.gmd.de.904973755 > armada.nfs: 140 lookup [|nfs] (DF)
21:10:17.329089 armada.nfs > buruk.fokus.gmd.de.904973755: reply ok 240 lookup [|nfs]
21:10:17.329166 buruk.fokus.gmd.de.921750971 > armada.nfs: 132 getattr [|nfs] (DF)
21:10:17.329361 armada.nfs > buruk.fokus.gmd.de.921750971: reply ok 112 getattr DIR 40775 ids 0/2000 [|nfs]
--Boundary-00=_4wJ/8COkqfjDkfn
Content-Type: text/x-log;
  charset="us-ascii";
  name="nfsstat.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="nfsstat.log"

Server rpc stats:
calls      badcalls   badauth    badclnt    xdrcall
0          0          0          0          0       
Server nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       wrcache    write      create     remove     rename     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 

Server nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       write      create     mkdir      symlink    mknod      
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
0       0% 0       0% 0       0% 0       0% 

Client rpc stats:
calls      retrans    authrefrsh
3883106    225        0       
Client nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 201    82% 0       0% 0       0% 38     15% 0       0% 
read       wrcache    write      create     remove     rename     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 0       0% 6       2% 

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 1625485 43% 425     0% 2107055 55% 20922   0% 284     0% 
read       write      create     mkdir      symlink    mknod      
7032    0% 511     0% 165     0% 0       0% 1       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
168     0% 0       0% 281     0% 8       0% 544     0% 0       0% 
fsstat     fsinfo     pathconf   commit     
64      0% 64      0% 0       0% 320     0% 


--Boundary-00=_4wJ/8COkqfjDkfn--
