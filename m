Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293109AbSCENwQ>; Tue, 5 Mar 2002 08:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293119AbSCENwH>; Tue, 5 Mar 2002 08:52:07 -0500
Received: from enseeiht.enseeiht.fr ([147.127.18.144]:61098 "EHLO
	enseeiht.enseeiht.fr") by vger.kernel.org with ESMTP
	id <S293109AbSCENv6>; Tue, 5 Mar 2002 08:51:58 -0500
X-Url: http://www.enseeiht.fr
Message-ID: <3C84CED2.2000603@enseeiht.fr>
Date: Tue, 05 Mar 2002 14:57:38 +0100
From: Emmanuel Chaput <Emmanuel.Chaput@enseeiht.fr>
Organization: ENSEEIHT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: timer question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Hi !

   I have a problem with the first part of run_timer_list() :

   if (!tv1.index) {
         int n = 1;
          do {
                 cascade_timers(tvecs[n]);
          } while (tvecs[n]->index == 1 && ++n < NOOF_TVECS);
    }

   My problem is that tv*.index is initialized to 0, so the first call to
run_timer_list() will result in a (useless) call to cascade_timers() for
tvecs[1..NOOF_TVECS - 1].

   Am I wrong ? Thanks to anyone who could help me  !

-- 
Emmanuel Chaput                         Dépt Télécom & Réseau, ENSEEIHT
*5 61 58 82 10 (Fax *5 61 58 80 14)         Emmanuel.Chaput@enseeiht.fr


