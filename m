Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313806AbSDIAvb>; Mon, 8 Apr 2002 20:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313807AbSDIAva>; Mon, 8 Apr 2002 20:51:30 -0400
Received: from ppp-225-39-53.friaco.access.uk.tiscali.com ([80.225.39.53]:260
	"EHLO hoffman.vilain.net") by vger.kernel.org with ESMTP
	id <S313806AbSDIAv0>; Mon, 8 Apr 2002 20:51:26 -0400
Date: Tue, 9 Apr 2002 01:50:55 +0100
From: Sam Vilain <sam@vilain.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Sailer <sailer@ife.ee.ethz.ch>
Cc: linux-kernel@vger.kernel.org
Subject: USB audio device - ABIT UA11 dual toslink I/O
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: NErb*2NY4\th?$s.!!]_9le_WtWE'b4;dk<5ot)OW2hErS|tE6~D3errlO^fVil?{qe4Lp_m\&Ja!;>%JqlMPd27X|;b!GH'O.,NhF*)e\ln4W}kFL5c`5t'9,(~Bm_&on,0Ze"D>rFJ$Y[U""nR<Y2D<b]&|H_C<eGu?ncl.w'<
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E16ujqZ-0000W2-00@hoffman.vilain.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've just bought a low cost USB audio device.  For about £45 the
device sports two optical SPDIF (=toslink) connectors (one in, one
out) clocking at 32kHz, 44.1kHz or 48kHz.  According to the specs it's
USB 1.1 and USB audio 1.1 compliant.  It is assembled and branded by
ABIT, model UA-11, the "i/Optica".

The audio module loads with these messages:
usb.c: registered new driver audio
usbaudio: device 2 audiocontrol interface 0 has 1 input and 1 output AudioStreaming interfaces
usbaudio: valid input sample rate 48000
usbaudio: valid input sample rate 32000
usbaudio: valid input sample rate 44100
usbaudio: device 2 interface 2 altsetting 1: format 0x00000010 sratelo 32000 sratehi 48000 attributes 0x01
usbaudio: valid input sample rate 48000
usbaudio: valid input sample rate 32000
usbaudio: valid input sample rate 44100
usbaudio: device 2 interface 2 altsetting 2: format 0x80000010 sratelo 32000 sratehi 48000 attributes 0x01
usbaudio: device 2 interface 1 altsetting 0 does not have an endpoint
usbaudio: valid output sample rate 48000
usbaudio: valid output sample rate 32000
usbaudio: valid output sample rate 44100
usbaudio: device 2 interface 1 altsetting 1: format 0x00000010 sratelo 32000 sratehi 48000 attributes 0x01
usbaudio: valid output sample rate 48000
usbaudio: valid output sample rate 32000
usbaudio: valid output sample rate 44100
usbaudio: device 2 interface 1 altsetting 2: format 0x80000010 sratelo 32000 sratehi 48000 attributes 0x01
usbaudio: registered dsp 14,19
usbaudio: constructing mixer for Terminal 10 type 0x0301
usbaudio: unit 8: invalid PROCESSING_UNIT descriptor
usbaudio: feature unit 9 source has no channels
usbaudio: no mixer controls found for Terminal 10
usbaudio: constructing mixer for Terminal 13 type 0x0101
usbaudio: selector unit 11: ignoring channel 1
usbaudio: selector unit 11: input pins with varying channel numbers
usbaudio: feature unit 12 source has no channels
usbaudio: no mixer controls found for Terminal 13
usb_audio_parsecontrol: usb_audio_state at d2bb6480
audio.c: v1.0.0:USB Audio Class driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
input0: USB HID v1.00 Pointer [KC Technology, Inc. KC USB Audio Device] on usb1:2.3
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers

The output from `lsusb' is a monster:

Bus 001 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            0.00
  iManufacturer           0 
  iProduct                2 USB UHCI-alt Root Hub
  iSerial                 1 cce0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval             255
  Language IDs: (length=4)
     0000 (null)((null))

Bus 001 Device 002: ID 050f:2178 KC Technology Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 Interface
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x050f KC Technology Inc.
  idProduct          0x2178 
  bcdDevice            1.00
  iManufacturer           1 KC Technology, Inc.
  iProduct                2 KC USB Audio Device
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          421
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              300mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength          164
        bInCollection           2
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0603 Line Connector
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0001
          Left Front (L)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            10
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               9
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            13
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID              12
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                 7
        bNrInPins               3
        baSourceID( 0)          4
        baSourceID( 1)          5
        baSourceID( 2)          6
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        bmControls         0x00
        iMixer                  0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                11
        bNrInPins               3
        baSource( 0)            2
        baSource( 1)            3
        baSource( 2)            7
        iSelector               0 
      AudioControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 4
        bSourceID               1
        bControlSize            2
        bmaControls( 0)      0x01
        bmaControls( 1)      0x00
          Mute
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 5
        bSourceID               2
        bControlSize            2
        bmaControls( 0)      0x01
        bmaControls( 1)      0x00
          Mute
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 6
        bSourceID               3
        bControlSize            2
        bmaControls( 0)      0x43
        bmaControls( 1)      0x00
          Mute
          Volume
          Automatic Gain
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 9
        bSourceID               8
        bControlSize            2
        bmaControls( 0)      0x01
        bmaControls( 1)      0x00
          Mute
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                12
        bSourceID              11
        bControlSize            2
        bmaControls( 0)      0x01
        bmaControls( 1)      0x00
          Mute
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      7 (PROCESSING_UNIT)
        bUnitID                 8
        wProcessType            3
        bNrPins                 1
        baSourceID( 0)          7
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        bControlSize            2
        bmControls( 0)       0x03
        bmControls( 1)       0x00
          Enable Processing
        iProcessing             0 
        Process-Specific    
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            3 Discrete
        tSamFreq[ 0]        48000
        tSamFreq[ 1]        44100
        tSamFreq[ 2]        32000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
        wMaxPacketSize        104
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay            512 Decoded PCM samples
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            3 Discrete
        tSamFreq[ 0]        48000
        tSamFreq[ 1]        44100
        tSamFreq[ 2]        32000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
        wMaxPacketSize        208
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay            512 Decoded PCM samples
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          13
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            3 Discrete
        tSamFreq[ 0]        48000
        tSamFreq[ 1]        44100
        tSamFreq[ 2]        32000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        104
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              0 Decoded PCM samples
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          13
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            3 Discrete
        tSamFreq[ 0]        48000
        tSamFreq[ 1]        44100
        tSamFreq[ 2]        32000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        208
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              0 Decoded PCM samples
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     152
cannot get report descriptor
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval              48
  Language IDs: (length=4)
     0409 English(US)

Here's some strace() output from sox:

[pid  1892] open("/dev/dsp1", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 4
[pid  1892] fstat64(4, {st_mode=S_IFCHR|0660, st_rdev=makedev(14, 19), ...}) = 0
[pid  1892] ioctl(4, SNDCTL_TMR_TIMEBASE, 0xbffffaa8) = -1 ENOIOCTLCMD (errno 515)
[pid  1892] old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
[pid  1892] fstat64(4, {st_mode=S_IFCHR|0660, st_rdev=makedev(14, 19), ...}) = 0
[pid  1892] ioctl(4, SNDCTL_DSP_RESET, 0) = 0
[pid  1892] ioctl(4, SNDCTL_DSP_SYNC, 0) = 0
[pid  1892] ioctl(4, SNDCTL_DSP_GETFMTS, 0xbffffc04) = 0
[pid  1892] ioctl(4, SOUND_PCM_READ_BITS, 0xbffffc04) = 0
[pid  1892] ioctl(4, SNDCTL_DSP_STEREO, 0xbffffc04) = 0
[pid  1892] ioctl(4, SOUND_PCM_READ_RATE, 0xbffffc04) = 0
[pid  1892] write(2, "sox: ", 5sox: )        = 5
[pid  1892] write(2, "Unable to set audio speed to 441"..., 45Unable to set audio speed to 44100 (set to 0)) = 45
[pid  1892] write(2, "\n", 1
)           = 1
[pid  1892] ioctl(4, SNDCTL_DSP_GETBLKSIZE, 0x80a52f0) = 0
[pid  1892] munmap(0x40017000, 4096)    = 0
[pid  1892] write(2, "sox: ", 5sox: )        = 5
[pid  1892] write(2, "bad output format", 17bad output format) = 17
[pid  1892] write(2, "\n", 1
)           = 1
[pid  1892] close(3)                    = 0
[pid  1892] munmap(0x40016000, 4096)    = 0
[pid  1892] close(4)                    = 0

`dd if=/dev/zero of=/dev/dsp1' writes about 256k before writes block.

`mpg123 -a /dev/dsp1 mymp3.mp3' is doing this:

open("/dev/dsp1", O_WRONLY)             = 3
ioctl(3, SNDCTL_DSP_GETBLKSIZE, 0x806e5a0) = 0
ioctl(3, SNDCTL_DSP_RESET, 0)           = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffffab0) = -1 EINVAL (Invalid argument)
ioctl(3, SOUND_PCM_READ_BITS, 0xbffffab0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffffaac) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffffaa8) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffffab0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffffaac) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffffaa8) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffffab0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffffaac) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffffaa8) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffffab0) = 0
<snip>
ioctl(3, SNDCTL_DSP_STEREO, 0xbffffaac) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffffaa8) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffffab0) = -1 EINVAL (Invalid argument)
close(3)                                = 0

As for the actual board inside the grey plastic case, it has two tiny
ICs on it - one is labelled "KC2178P", the other "XWM9707" + "16ADAU2"

So, what do you think?  Start reading at
http://www.usb.org/developers/data/devclass/audio10.pdf, or is there
an easy solution to this?  Perhaps some information on deciphering the
output of `lsusb'?

FWIW it works perfectly under Windows with no (advertised) special
support by the Windows USB audio driver.
--
   Sam Vilain, sam@vilain.net     WWW: http://sam.vilain.net/
    7D74 2A09 B2D3 C30F F78E      GPG: http://sam.vilain.net/sam.asc
    278A A425 30A9 05B5 2F13
