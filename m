Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284518AbRLIVzT>; Sun, 9 Dec 2001 16:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284491AbRLIVzH>; Sun, 9 Dec 2001 16:55:07 -0500
Received: from dialin-145-254-137-158.arcor-ip.net ([145.254.137.158]:14852
	"EHLO dale.home") by vger.kernel.org with ESMTP id <S284488AbRLIVys>;
	Sun, 9 Dec 2001 16:54:48 -0500
Date: Sun, 9 Dec 2001 22:54:35 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: xine-user@lists.sourceforge.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.17-pre2 (and 6) The failed "Read CD" packet command was
Message-ID: <20011209225435.A310@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just seen the attached messages while playing a VCD
with xine(0.9.5). I dont know, maybe it's not good to 
play vcd, or not good to have a such cd-drive.
Could someone explain?
With linux kernel 2.4.17-pre6 it didn't produce the error
(but the stops while playing are still there). Maybe it's
just xine's problem? After all it has 8-9 threads...
xine output is attached.

vmstat reports unusual high number of context switches
(thread stop - start?)
(>1000 whereas usually 500-600) sometimes. And playback
pauses for ~1 sec. Not especially good.

first vmstat:
 0  0  0      0 342976   6460  54204   0   0     0     0  154   498   0   0 100
 0  0  0      0 342956   6460  54204   0   0     0     0  363   960  12   6  82
 1  0  0      0 342956   6460  54204   0   0     0     0  248   776   2   1  97
 0  0  0      0 342940   6460  54204   0   0     0     0  250   642   1   0  99
second one:
 1  0  0      0 342948   6460  54204   0   0     0     0  176   548   0   1  99
 1  0  0      0 342932   6460  54204   0   0     0     0  347   903  12   4  84
 0  0  0      0 342932   6460  54204   0   0     0     0  256   779   4   0  96
 0  0  0      0 342932   6460  54204   0   0     0     0  255   765   3   0  97
 0  0  0      0 342932   6460  54204   0   0     0     0  256   775   4   0  96


Dec  8 16:30:15 steel kernel:   The failed "Read CD" packet command was: 
Dec  8 16:30:15 steel kernel:   "be 00 00 05 69 f9 00 00 01 f8 00 00 " 
Dec  8 16:30:15 steel kernel: hdd: packet command error: status=0x51 { DriveReady SeekComplete Error } 
Dec  8 16:30:15 steel kernel: hdd: packet command error: error=0x54 
Dec  8 16:30:15 steel kernel: ATAPI device hdd: 
Dec  8 16:30:15 steel kernel:   Error: Illegal request -- (Sense key=0x05) 
Dec  8 16:30:15 steel kernel:   Invalid command operation code -- (asc=0x20, ascq=0x00) 
Dec  8 16:30:15 steel kernel:   The failed "<NULL>" packet command was: 
Dec  8 16:30:15 steel kernel:   "15 10 00 00 0c 00 00 00 00 00 00 00 " 
Dec  8 16:30:15 steel kernel:   Error in command packet byte 0 bit 0 


Linux steel 2.4.17-pre2 #12 Tue Dec 4 19:58:08 CET 2001 i686 unknown
PIII, compiled with PIII
ide-cdrom version 4.59
Model: CD-540E
/proc/ide/ide1/hdd/settings
name			value		min		max		mode
----			-----		---		---		----
breada_readahead        4               0               127             rw
current_speed           66              0               69              rw
dsc_overlap             0               0               1               rw
file_readahead          0               0               2097151         rw
ide_scsi                0               0               1               rw
init_speed              12              0               69              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
max_kb_per_request      127             1               127             rw
nice1                   1               0               1               rw
number                  3               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               1               0               1               rw
using_dma               1               0               1               rw

/proc/ide/via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.29
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
Highest DMA rate:                   UDMA66
BM-DMA base:                        0xd800
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                  no
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       PIO      UDMA
Address Setup:       30ns     120ns     120ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns     330ns      90ns
Data Recovery:       30ns     270ns     270ns      30ns
Cycle Time:          30ns     600ns     600ns      60ns
Transfer Rate:   66.0MB/s   3.3MB/s   3.3MB/s  33.0MB/s


With 2.5.1-pre7 xine cannot play that cd - unexplainable error in 
"input_vcd : error in ioctl CDROMREADTOCHDR".


xine console:

audio_oss_out: audio rate : 44100 requested, 44100 provided by device/sec
audio_oss_out : 2 channels output
audio_out: output sample rate 44100
audio_out: thread created
metronom: audio pts discontinuity/start, pts is 92282282, last_pts is 92288143, wrap_offset = 64463
metronom: forcing video_wrap (58583) and audio wrap (64463) to 64463
200 frames delivered, 17 frames skipped, 9 frames discarded
200 frames delivered, 0 frames skipped, 0 frames discarded
...
200 frames delivered, 0 frames skipped, 0 frames discarded
audio_decoder: discontinuity ahead
audio_out: stopping thread...
audio_out: thread stopped, closing driver
video_decoder: discontinuity ahead
libmpeg2: blasting out backward reference frame on flush
metronom: video discontinuity
metronom: audio discontinuity
metronom: audio discontinuity => last_audio_pts=96485906, wrap_offset=64463, audio_vpts=96550369
metronom: video vpts adjusted to 96550369
metronom: video discontinuity => last_video_pts=96485906, wrap_offset=64463, video_vpts=96550369
metronom: video pts discontinuity, pts is 96500160, last_pts is 96485906, wrap_offset = 68209
200 frames delivered, 9 frames skipped, 4 frames discarded
audio_loop: using decoder >mad< 
libmad: audio sample rate 44100 mode 00000008
audio_oss_out: ao_open rate=44100, mode=8
audio_oss_out: audio rate : 44100 requested, 44100 provided by device/sec
audio_oss_out : 2 channels output
audio_out: output sample rate 44100
audio_out: thread created
metronom: audio pts discontinuity/start, pts is 96485906, last_pts is 96485906, wrap_offset = 64465
metronom: forcing video_wrap (68209) and audio wrap (64465)to 68209
200 frames delivered, 0 frames skipped, 0 frames discarded
200 frames delivered, 0 frames skipped, 0 frames discarded



