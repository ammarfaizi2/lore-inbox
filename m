Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbTCQOXu>; Mon, 17 Mar 2003 09:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261694AbTCQOXu>; Mon, 17 Mar 2003 09:23:50 -0500
Received: from valaran.com ([66.153.38.244]:26357 "HELO vader.valaran.com")
	by vger.kernel.org with SMTP id <S261693AbTCQOXs>;
	Mon, 17 Mar 2003 09:23:48 -0500
Date: Mon, 17 Mar 2003 09:34:43 -0500
From: "Keith R. John Warno" <keith.warno@valaran.com>
To: Burton Windle <bwindle@fint.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "kernel BUG at page_alloc.c:102!" (kernel 2.4.20)
Message-ID: <F79AB9D620031047911180.15123.smtp@valaran.com>
Mail-Followup-To: Burton Windle <bwindle@fint.org>,
	linux-kernel@vger.kernel.org
References: <8EE4126620031047901034.13328.smtp@valaran.com> <Pine.LNX.4.43.0303170847020.746-100000@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0303170847020.746-100000@morpheus>
Organization: Valaran Corporation
User-Agent: Mutt 1.4i (2002-05-29)
X-Mailer: Mutt 1.4i (2002-05-29)
X-Editor: VIM - Vi IMproved 6.1 (2002 Mar 24, compiled Dec 13 2002 12:46:19)
X-Operating-System: GNU/Linux (2.4.20)
X-Location: USA, New Jersey, Trenton
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Burton Windle <bwindle@fint.org> [17/03/2003 0847EST]:
> What modules do you have loaded?
> 

Oh yes I forgot to mention those didn't I.  :-/  The kernel is tainted
because of the !@#^%*#@* NVidia closed-source driver (1.0-3123).  I have
ALSA 0.9.0rc6 stuff loaded (yes, old; have yet to update it).
Everything else is stock 2.4.20 kernel stuff. (I am aware there is an
NVidia 1.0-4191 driver set, but  it didn't play nice so I reverted to
the previous release.)

Here is the lsmod output:
Module                  Size  Used by    Tainted: P  
snd-emu10k1            57636   0 
snd-hwdep               3680   0  [snd-emu10k1]
snd-util-mem            1168   0  [snd-emu10k1]
snd-rawmidi            11936   0  [snd-emu10k1]
snd-ac97-codec         25776   0  [snd-emu10k1]
snd-pcm-oss            36964   0 
snd-pcm                54560   0  [snd-emu10k1 snd-pcm-oss]
snd-timer              10400   0  [snd-pcm]
snd-mixer-oss          10752   0  [snd-pcm-oss]
snd                    24008   0  [snd-emu10k1 snd-hwdep snd-util-mem snd-rawmidi snd-ac97-codec snd-pcm-oss snd-pcm snd-timer snd-mixer-oss]
soundcore               3364   6  [snd]
NVdriver             1066528  10 
agpgart                12800   3 
loop                    8496   0  (unused)
autofs4                 8580   1 
nfs                    44932   0  (unused)
nfsd                   44928   0  (unused)
lockd                  37248   0  [nfs nfsd]
sunrpc                 59924   0  [nfs nfsd lockd]
tulip                  37664   1 
mousedev                3904   1 
hid                    13248   0  (unused)
input                   3168   0  [mousedev hid]
usb-uhci               21796   0  (unused)
usbcore                55232   0  [hid usb-uhci]
serial                 44128   0  (unused)

krjw.
-- 
Keith R. John Warno                         [SA, Valaran Corporation]
"When you go into  court you are putting your fate  into the hands of
twelve people who weren't smart enough to get out of jury duty."
                -- Norm Crosby
