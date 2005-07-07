Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVGGStH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVGGStH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 14:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVGGStH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 14:49:07 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:14025 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261587AbVGGSrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:47:49 -0400
Message-ID: <24833.195.245.190.94.1120761991.squirrel@www.rncbc.org>
Date: Thu, 7 Jul 2005 19:46:31 +0100 (WEST)
Subject: realtime-preempt-2.6.12-final-V0.7.51-11 glitches
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050707194631_82836"
X-Priority: 3 (Normal)
Importance: Normal
References: <1119299227.20873.113.camel@cmn37.stanford.edu>    
    <20050621105954.GA18765@elte.hu>    
    <1119370868.26957.9.camel@cmn37.stanford.edu>    
    <20050621164622.GA30225@elte.hu>    
    <1119375988.28018.44.camel@cmn37.stanford.edu>    
    <1120256404.22902.46.camel@cmn37.stanford.edu>    
    <20050703133738.GB14260@elte.hu>   
    <1120428465.21398.2.camel@cmn37.stanford.edu>
In-Reply-To: <1120428465.21398.2.camel@cmn37.stanford.edu>
X-OriginalArrivalTime: 07 Jul 2005 18:47:46.0421 (UTC) FILETIME=[5DB63250:01C58324]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20050707194631_82836
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

Hi all,

These are one of my latest consolidated results while using (my)
jack_test4.2 suite, against a couple of 2.6.12 kernels patched for
PREEMPT_RT, on my P4@2.5GHz/UP laptop.

See anything funny?

As it seems, the kernel latency performance is in some unfortunate
regression, and I'm experiencing this unsatisfactory behavior ever since
the latest RT-V0.7.50-xx patch series.

  ------------------------------ ------------- -------------
                                 RT-V0.7.51-11 RT-V0.7.49-01
  ------------------------------ ------------- -------------
  Total seconds ran . . . . . . :      900           900
  Number of clients . . . . . . :       14            14
  Ports per client  . . . . . . :        4             4
  Frames per buffer . . . . . . :       64            64
  Number of runs  . . . . . . . :        1             1
  ------------------------------ ------------- -------------
  Failure Rate  . . . . . . . . :   (    0.0 )    (    0.0)  /hour
  XRUN Rate . . . . . . . . . . :      373.3           0.0   /hour
  Delay Rate (>spare time)  . . :      220.0           0.0   /hour
  Delay Rate (>1000 usecs)  . . :        0.0           0.0   /hour
  Delay Maximum . . . . . . . . :     7853           295     usecs
  Cycle Maximum . . . . . . . . :      852           943     usecs
  Average DSP Load. . . . . . . :       41.8          44.4   %
  Average CPU System Load . . . :        6.8          16.3   %
  Average CPU User Load . . . . :       28.8          30.1   %
  Average CPU Nice Load . . . . :        0.0           0.0   %
  Average CPU I/O Wait Load . . :        0.0           0.1   %
  Average CPU IRQ Load  . . . . :        0.0           0.0   %
  Average CPU Soft-IRQ Load . . :        0.0           0.0   %
  Average Interrupt Rate  . . . :     1679.3        1680.4   /sec
  Average Context-Switch Rate . :    12508.6       14463.2   /sec
  ------------------------------ ------------- -------------

JFYI respective kernel configs are also attached.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


------=_20050707194631_82836
Content-Type: application/x-gzip-compressed; name="jack_test4.2.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="jack_test4.2.tar.gz"

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
Bv8A8jmKvwDwAAA=
------=_20050707194631_82836
Content-Type: application/octet-stream;
      name="config-2.6.12-RT-V0.7.49-01.0.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config-2.6.12-RT-V0.7.49-01.0.gz"


------=_20050707194631_82836
Content-Type: application/octet-stream;
      name="config-2.6.12-RT-V0.7.51-11.0.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config-2.6.12-RT-V0.7.51-11.0.gz"


------=_20050707194631_82836--


