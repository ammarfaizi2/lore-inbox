Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbUKQEqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbUKQEqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 23:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbUKQEjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 23:39:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56843 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262215AbUKQEey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 23:34:54 -0500
Date: Wed, 17 Nov 2004 05:32:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove outdated OSS Changelogs (fwd)
Message-ID: <20041117043226.GG4943@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The trivial patch forwarded below still pplies against 2.6.10-rc2-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Wed, 27 Oct 2004 22:50:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove outdated OSS Changelogs


There's not much value in shipping Changelogs that weren't updated since 
at least 2.4.0 .

diffstat output:
 Documentation/sound/oss/ChangeLog.awe        |  230 -------------------
 Documentation/sound/oss/ChangeLog.multisound |  213 -----------------
 2 files changed, 443 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/Documentation/sound/oss/ChangeLog.multisound	2004-10-18 23:53:45.000000000 +0200
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,213 +0,0 @@
-1998-12-04  Andrew T. Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.8.2.2
-
-	* Add msndreset program to shell archive.
-
-1998-11-11  Andrew T. Veliath  <andrewv@usa.net>
-
-	* msnd_pinnacle.c (mixer_ioctl): Add a mixer ioctl for
-	SOUND_MIXER_PRIVATE1 which does a full reset on the card.
-	(mixer_set): Move line in recording source to input monitor, aux
-	input level added, some mixer fixes.
-
-1998-09-10  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.8.2
-
-	* Add SNDCTL_DSP_GETOSPACE and SNDCTL_DSP_GETISPACE ioctls.
-
-1998-09-09  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.8.1
-	
-	* msnd_pinnacle.c: Fix resetting of default audio parameters. Turn
-	flush code from dsp_halt into dsp_write_flush, and use that for
-	SNDCTL_DSP_SYNC.
-
-1998-09-07  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.8.0
-
-	* Provide separate signal parameters for play and record.
-	
-	* Cleanups to locking and interrupt handling, change default
-	fifosize to 128kB.
-
-	* Update version to 0.7.15
-
-	* Interprocess full-duplex support (ie `cat /dev/dsp > /dev/dsp').
-
-	* More mutex sections for read and write fifos (read + write locks
-	added).
-
-1998-09-05  Andrew Veliath  <andrewtv@usa.net>
-
-	* msnd_pinnacle.c: (chk_send_dsp_cmd) Do full DSP reset upon DSP
-	timeout (when not in interrupt; maintains mixer settings).  Fixes
-	to flushing and IRQ ref counting. Rewrote queuing for smoother
-	playback and fixed initial playback cutoff problem.
-
-1998-09-03  Andrew Veliath  <andrewtv@usa.net>
-
-	* Replaced packed structure accesses with standard C equivalents.
-
-1998-09-01  Andrew Veliath  <andrewtv@usa.net>
-
-	* msnd_pinnacle.c: Add non-PnP configuration to driver code, which
-	  will facilitate compiled-in operation.
-
-1998-08-29  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.7.6
-	
-	* msnd_pinnacle.c (dsp_ioctl): Add DSP_GETFMTS, change SAMPLESIZE
-	  to DSP_SETFMT.
-
-	* Update version to 0.7.5
-	
-	* Create pinnaclecfg.c and turn MultiSound doc into a shell
-	  archive with pinnaclecfg.c included.  pinnaclecfg.c can
-	  now fully configure the card in non-PnP mode, including the
-	  joystick and IDE controller.  Also add an isapnp conf
-	  example.
-
-	* Reduce DSP reset timeout from 20000 to 100
-
-1998-08-06  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.7.2
-	
-	* After A/D calibration, do an explicit set to the line input,
-	  rather than using set_recsrc
-
-1998-07-20  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.7.1
-
-	* Add more OSS ioctls
-	
-1998-07-19  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update doc file
-	
-	* Bring back DIGITAL1 with digital parameter to msnd_pinnacle.c
-	  and CONFIG_MSNDPIN_DIGITAL.  I'm not sure this actually works,
-	  since I find audio playback goes into a very speeded mode of
-	  operation, however it might be due to a lack of a digital
-	  source, which I don't have to test.
-
-1998-07-18  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.7.0
-
-	* Can now compile with Alan Cox' 2.0.34-modular-sound patch (so
-	  now it requires >= 2.1.106 or 2.0.34-ms) (note for 2.0.34-ms it
-	  is in the Experimental section)
-
-	* More modularization, consolidation, also some MIDI hooks
-	  installed for future MIDI modules
-
-	* Write flush
-
-	* Change default speed, channels, bit size to OSS/Free defaults
-
-1998-06-02  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.5b
-
-	* Fix version detection
-	
-	* Remove underflow and overflow resets (delay was too long)
-
-	* Replace spinlocked bitops with atomic bit ops
-
-1998-05-27  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.5a
-	
-	* Better recovery from underflow or overflow conditions
-	
-	* Fix a deadlock condition with one thread reading and the other
-	  writing
-
-1998-05-26  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.5
-	
-	* Separate reset queue functions for play and record
-
-	* Add delays in dsp_halt
-
-1998-05-24  Andrew Veliath  <andrewtv@usa.net>
-
-	* Add a check for Linux >= 2.1.95
-	
-	* Remove DIGITAL1 input until I figure out how to make it work
-	
-	* Add HAVE_DSPCODEH which when not defined will load firmware from
-	  files using mod_firmware_load, then release memory after they
-	  are uploaded (requires reorganized OSS).
-
-1998-05-22  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.4c
-
-	* Hopefully fix the mixer volume problem
-
-1998-05-19  Andrew Veliath  <andrewtv@usa.net>
-
-	* Add __initfuncs and __initdatas to reduce resident code size
-
-	* Move bunch of code around, remove some protos
-
-	* Integrate preliminary changes for Alan Cox's OSS reorganization
-	  for non-OSS drivers to coexist with OSS devices on the same
-	  major.  To compile standalone, must now define STANDALONE.
-
-1998-05-16  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.4b
-	
-	* Integrated older card support into a unified driver, tested on a
-	  MultiSound Classic c/o Kendrick Vargas.
-
-1998-05-15  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.4
-	
-	* Fix read/write return values
-
-1998-05-13  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.3
-
-	* Stop play gracefully
-
-	* Add busy flag
-	
-	* Add major and calibrate_signal module parameters
-	
-	* Add ADC calibration
-
-	* Add some OSS compatibility ioctls
-
-	* Add mixer record selection
-	
-	* Add O_NONBLOCK support, separate read/write wait queues
-
-	* Add sample bit size ioctl, expanded sample rate ioctl
-
-	* Playback suspension now resumes
-
-	* Use signal_pending after interruptible_sleep_on
-	
-	* Add recording, change ints to bit flags
-
-1998-05-11  Andrew Veliath  <andrewtv@usa.net>
-
-	* Update version to 0.2
-
-	* Add preliminary playback support
-
-	* Use new Turtle Beach DSP code
\ No newline at end of file
--- linux-2.6.10-rc1-mm1-full/Documentation/sound/oss/ChangeLog.awe	2004-10-18 23:55:36.000000000 +0200
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,230 +0,0 @@
-ver.0.4.3p4
-	- Bug fix for invalid memory detection when initialized twice
-	- Add sample sharing function - works together with awesfx-0.4.3p3
-	- Add AWE_PROBE_DATA for probing sample id
-
-ver.0.4.3p3
-	- Replace memset to MEMSET (for FreeBSD)
-	- Add PAN_EXCHANGE switch
-
-ver.0.4.3p2
-	- MIDI emulation device is added
-	- Controls volume and filter targets
-	- Include chorus/reverb/equalizer values in MISC_MODE
-
-ver.0.4.3p1
-	- Change the volume calculation method
-	- Support for Tom Lees' PnP driver (v0.3)
-
-ver.0.4.2d
-	- Support for OSS/Free 3.8 on 2.0 kernels.
-	- Support for Linux PnP driver
-	- Support for module (for recent 2.1 kernels and RH5.0)
-	- Support for FreeBSD-3.0 system
-
-ver.0.4.2c
-	- Add a mode to enable drum channel toggle via bank number
-	  change.
-
-ver.0.4.2b
-	- Clear voice position after note on
-	- Change nrvoices according to the current playing mode
-
-ver.0.4.2a
-	- Fix a bug in pitch calculation with scale parameter
-	- Change default chorus & reverb modes
-
-ver.0.4.2
-	- Use indirect voice allocation mode; used as default mode
-	- Add preset mapping
-	- Free buffers when resetting samples
-	- Set default preset/bank/drumset as variable
-	- Fix a bug in exclusive note-off
-	- Add channel reset control macro
-	- Change modwheel sensitivity as variable
-	- Add lock option in open_patch
-	- Add channel priority mode macro, and disable it as default
-	- Add unset effect macro
-	- Add user defined chorus/reverb modes
-	- Do not initialize effect parameters when allocating voices
-	- Accept realtime filter-Q parameter change
-	- Check value range of set/add effects
-	- Change drum flags automatically when receiving bank #128
-
-ver.0.4.1	development versions
-
-ver.0.4.0c
-	- Fix kernel oops when setting AWE_FX_ATTEN
-
-ver.0.4.0b
-	- Do not kill_note in start_note when velocity is zero
-
-ver.0.4.0a
-	- Fix a bug in channel pressure effects
-
-ver.0.4.0
-	- Support dynamic buffer allocation
-	- Add functions to open/close/unload a patch
-	- Change from pointer to integer index in voice/sample lists
-	- Support for Linux/Alpha-AXP
-	- Fix for FreeBSD
-	- Add sostenuto control
-	- Add midi channel priority
-	- Fix a bug in all notes off control
-	- Use AWE_DEFAULT_MEMSIZE always if defined
-	- Fix a bug in awe_reset causes seg fault when no DRAM onboard
-	- Use awe_mem_start variable instead of constant
-
-ver.0.3.3c
-	- Fix IOCTL_TO_USER for OSS-3.8 (on Linux-2.1.25)
-	- Fix i/o macros for mixer controls
-
-ver.0.3.3b
-	- Fix version number in awe_version.h
-	- Fix a small bug in noteoff/release all
-
-ver.0.3.3a
-	- Fix all notes/sounds off
-	- Add layer effect control
-	- Add misc mode controls; realtime pan, version number, etc.
-	- Move gus bank control in misc mode control
-	- Modify awe_operations for OSS3.8b5
-	- Fix installation script
-
-ver.0.3.3
-	- Add bass/treble control in Emu8000 chip
-	- Add mixer device
-	- Fix sustain on to value 127
-
-ver.0.3.2
-	- Refuse linux-2.0.0 at installation
-	- Move awe_voice.h to /usr/include/linux
-
-ver.0.3.1b (not released)
-	- Rewrite chorus/reverb mode change functions
-	- Rewrite awe_detect & awe_check_dram routines
-
-ver.0.3.1a
-	- Fix a bug to reset voice counter in awe_reset
-	- Fix voice balance on GUS mode
-	- Make symlink on /usr/include/asm in install script
-
-ver.0.3.1
-	- Remove zero size arrays from awe_voice.h
-	- Fix init_fm routine
-	- Remove all samples except primary samples in REMOVE_LAST_SAMPLES
-
-ver.0.3.0a
-	- Add AWE_NOTEOFF_ALL control
-	- Remove AWE_INIT_ATTEN control
-
-ver.0.3.0
-	- Fix decay time table
-	- Add exclusive sounds mode
-	- Add capability to get current status
-
-ver.0.2.99e
-	- Add #ifdef for all sounds/notes off controls.
-	- Fix bugs on searching the default drumset/preset.
-	- Fix usslite patch to modify the default Config.in.
-
-ver.0.2.99d
-	- Fix bugs of attack/hold parameters
-	- Fix attack & decay time table
-
-ver.0.2.99c
-	- Change volume control messages (main & expression volume)
-	  to accesspt normal MIDI parameters in channel mode.
-	- Use channel mode in SEQ2 controls.
-
-ver.0.2.99b
-	- #ifdef patch manager functions (for OSS-3.7)
-
-ver.0.2.99a
-	- Fix sustain bug
-
-ver.0.2.99 (0.3 beta)
-	- Support multiple instruments
-
-ver.0.2.0c
-	- Add copyright notice
-	- FreeBSD 2.2-ALPHA integration
-
-ver.0.2.0b
-	- Remove buffered reading appended in v0.2.0a
-	- Remove SMAxW register check on writing
-	- Support Linux 2.1.x kernel
-	- Rewrite installation script
-
-ver.0.2.0a
-	- Define SEQUENCER_C for tuning.h for FreeBSD system
-	- Improvement of sample loading speed
-	- Fix installation script
-	- Add PnP driver functions for ISA PnP driver support
-
-ver.0.2.0
-	- Includes FreeBSD port
-	- Can load GUS compatible patches
-	- Change values of hardware control parameters for compatibility
-	  with GUS driver
-	- Accept 8bit or unsigned wave data
-	- Accept no blank loop data
-	- Add sample mode flags in sample_info
-
-ver.0.1.6
-	- Add voice effects control
-	- Fix awe_voice.h for word alignment
-
-ver.0.1.5c
-	- Fix FM(OPL) playback problem
-
-ver.0.1.5b
-	- Fix pitch calculation for fixed midi key
-
-ver.0.1.5a
-	- Fix bugs in removing samples from linked list.
-
-ver.0.1.5
-	- Add checksum verification for sample uploading
-	  (not compatible from older sample_info structure)
-	- Fix sample offset pointers to (actual value - 1)
-	- Add sequencer command to initialize awe32
-
-ver.0.1.4c
-	- Fix card detection and memory check function to avoid system crash
-	  at booting
-
-ver.0.1.4b
-	- Add release sustain mode
-	- Initialize FM each time after loading samples
-
-ver.0.1.4a
-	- Fix AWE card detection code
-	- Correct FM initialize position 
-	- Add non-releasing mode on voice info
-
-ver.0.1.4
-	- Add AWE card and DRAM detection codes
-	- Add FM initialization code
-	- Modify volume control
-	- Remove linear volume mode
-	- Change memory management; not using malloc dynamically
-	- Add remove-samples command
-	- Use internal id implicitly at loading samples
-
-ver.0.1.3
-	- Fix a bug on patch uploading to RAM
-
-ver.0.1.2
-	- Divide to separated packages
-	- Fix disagreed macro conditions
-	- Fix unresolved function bugs
-	- Integrate VoxWare and USS-Lite driver source (awe_voice.c)
-	  and remove awe_card.c
-
-ver.0.1.1
-	- Fix wrong sample numbers in sbktext
-	- Fix txt2sfx bug
-	- Fix pan parameter calculation
-	- Append USS-Lite/Linux2.0 driver
-


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

