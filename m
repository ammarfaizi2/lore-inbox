Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262368AbSJ0Lpe>; Sun, 27 Oct 2002 06:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262369AbSJ0Lpe>; Sun, 27 Oct 2002 06:45:34 -0500
Received: from mail59-s.fg.online.no ([148.122.161.59]:9869 "EHLO
	mail59.fg.online.no") by vger.kernel.org with ESMTP
	id <S262368AbSJ0Lpd> convert rfc822-to-8bit; Sun, 27 Oct 2002 06:45:33 -0500
Subject: Trouble with a cmpci soundcard.
From: "Nils O." =?ISO-8859-1?Q?Sel=E5sdal?= <noselasd@frisurf.no>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 Oct 2002 12:57:44 +0100
Message-Id: <1035719869.4813.17.camel@space>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have this soundcard:
  Bus  0, device  13, function  0:
    Multimedia audio controller: C-Media Electronics Inc CM8338A (rev
16).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=24.
      I/O at 0xe400 [0xe4ff].

And using the cmpci driver.
The problem is, mostly the sound is nogood, most sound comes from one
speaker, and it just sounds completly screwd up. Atleast with most
programs shuch as xmms, mplayer, most games. However with mpg123 and
ogg123 it sounds fine.
Now, for the programs which i can set to run in 8 bit modus (e.g. 
esd -b, artsd -b 8 ) the sound is also fine. Is this really an 8 bit 
soundcard ? 
What troubles me is that with a 2.4.2 kernel(at least the one from
Redhat, 7.2 I believe it was ), I didn't have to do anything special,
the sound was always ok. The next kernel I tried was 2.4.5, not ok,
Now running 2.4.20-pre11, same problems here, so I installed ALSA
and with its snd-cmipci driver sound is alwasy fine, so I do think 
there is something fishy with the cmpci driver...

[noselasd@space noselasd]$ cat /proc/interrupts 
           CPU0       
  0:   15323118          XT-PIC  timer
  1:     123539          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:     484266          XT-PIC  usb-uhci, CMI8338
  8:          1          XT-PIC  rtc
 10:     730343          XT-PIC  eth0
 11:    9400218          XT-PIC  nvidia
 12:     807195          XT-PIC  PS/2 Mouse
 14:     516395          XT-PIC  ide0
 15:         27          XT-PIC  ide1
NMI:          0 
ERR:          0


-- 
Nils Olav Selåsdal <NOS@Utel.no>
System Developer, UtelSystems a/s
w w w . u t e l s y s t e m s . c o m


