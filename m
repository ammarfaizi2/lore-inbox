Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311829AbSCXSvd>; Sun, 24 Mar 2002 13:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311840AbSCXSvX>; Sun, 24 Mar 2002 13:51:23 -0500
Received: from netroute.netroute.cz ([62.40.73.2]:41351 "EHLO netroute")
	by vger.kernel.org with ESMTP id <S311829AbSCXSvM>;
	Sun, 24 Mar 2002 13:51:12 -0500
Date: Sun, 24 Mar 2002 14:26:17 +0100
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Strange behaviour of GUS + OSS driver
Message-ID: <20020324142617.A28009@ghost.cybernet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I got this sound card and driver combination:

isapnp: Card 'Advanced Gravis InterWave Audio'
isapnp: 1 Plug & Play card detected total

snd-pcm-oss            33584   0 (autoclean)
snd-mixer-oss           8176   0 (autoclean) [snd-pcm-oss]
snd-card-interwave      6768   0
snd-gus                26592   0 [snd-card-interwave]
snd-rawmidi            10752   0 [snd-gus]
snd-seq-device          3600   0 [snd-gus snd-rawmidi]
snd-cs4231             12304   0 [snd-card-interwave]
snd-pcm                41824   0 [snd-pcm-oss snd-gus snd-cs4231]
snd-timer               8624   0 [snd-gus snd-cs4231 snd-pcm]
isapnp                 26448   0 [snd-card-interwave]
snd                    24944   0 [snd-pcm-oss snd-mixer-oss snd-card-interwave snd-gus snd-rawmidi snd-seq-device snd-cs4231 snd-pcm snd-timer]

  < > Internal PC speaker support                                           
  < > Trident 4DWave DX/NX or SiS 7018 PCI Audio Core or ALi 5451           
  < > Support for Turtle Beach MultiSound Classic, Tahiti, Monterey         
  < > Support for Turtle Beach MultiSound Pinnacle, Fiji                    
  < > VIA 82C686 Audio Codec                                                
  <M> OSS sound modules                                                     
  < > ProAudioSpectrum 16 support                                           
  < > 100% Sound Blaster compatibles (SB16/32/64, ESS, Jazz16) support      
  <M> Gravis Ultrasound support                                             
  [ ] 16 bit sampling option of GUS (_NOT_ GUS MAX)                         
  [*] GUS MAX support                                                       
  < > MPU-401 support (NOT for SB16)                                        
  < > PSS (AD1848, ADSP-2115, ESC614) support                               
  < > Microsoft Sound System support                                        
  < > Ensoniq SoundScape support                                            
  < > MediaTrix AudioTrix Pro support                                       

Time to time, a white noise (hiss) begins to be added to either left or right
channel of played-back mp3's, ogg vorbises, and modules (mpg123, ogg123, xmp).
>From that point on, the noise is in the channel permanently except when no
audio output is being performed. Only reboot cures this.

My friend has got the same card and experiences the same problems.

-- 
Karel 'Clock' Kulhavy
