Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSKCAhj>; Sat, 2 Nov 2002 19:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSKCAhi>; Sat, 2 Nov 2002 19:37:38 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:7040 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S261529AbSKCAhb>;
	Sat, 2 Nov 2002 19:37:31 -0500
Date: Sat, 2 Nov 2002 18:43:57 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Working ide-cd burn/rip, 2.5.44
Message-Id: <20021102184357.7091fd4d.arashi@arashi.yi.org>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sat__2_Nov_2002_18:43:57_-0600_081e4e00"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Sat__2_Nov_2002_18:43:57_-0600_081e4e00
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Just FYI. I tested the ide-cd based CD burning and reading with the
cdrtools alpha ... kernel 2.5.44-mm6, cdrtools-1.11a39. If I boot
into a clean system, only load ide-cd (none of the ide-scsi-related
bits), and "do it", it works well.

Invocations:
cdda2wav dev=/dev/hdc 1
cdrecord dev=ATAPI:0,0,0 -data dir.iso

I do get a lot of warnings from the block layer, though, as below.
I get some warnings, then it counts down, and it spits out more
warnings, but then it tells me it wrote out a track, writes the TOC,
and terminates successfully.

Matt

-----------------------------------------------------------------------
spurious 8259A interrupt: IRQ7.
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Mode Sense 10" packet command was: 
  "5a 00 30 00 00 00 00 00 02 00 00 00 00 00 00 00 "
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Mode Sense 10" packet command was: 
  "5a 00 30 00 00 00 00 00 08 00 00 00 00 00 00 00 "
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid command operation code -- (asc=0x20, ascq=0x00)
  The failed "<NULL>" packet command was: 
  "e9 00 02 00 00 00 00 00 00 00 08 00 00 00 00 00 "
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Mode Sense 10" packet command was: 
  "5a 00 30 00 00 00 00 00 02 00 00 00 00 00 00 00 "
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Mode Sense 10" packet command was: 
  "5a 00 30 00 00 00 00 00 08 00 00 00 00 00 00 00 "
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in parameter list -- (asc=0x26, ascq=0x00)
  The failed "Mode Select 10" packet command was: 
  "55 10 00 00 00 00 00 00 10 00 00 00 00 00 00 00 "
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Mode Sense 10" packet command was: 
  "5a 00 30 00 00 00 00 00 02 00 00 00 00 00 00 00 "
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Mode Sense 10" packet command was: 
  "5a 00 30 00 00 00 00 00 08 00 00 00 00 00 00 00 "
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid command operation code -- (asc=0x20, ascq=0x00)
  The failed "<NULL>" packet command was: 
  "e9 00 02 00 00 00 00 00 00 00 08 00 00 00 00 00 "
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Mode Sense 10" packet command was: 
  "5a 00 30 00 00 00 00 00 02 00 00 00 00 00 00 00 "
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Mode Sense 10" packet command was: 
  "5a 00 30 00 00 00 00 00 08 00 00 00 00 00 00 00 "
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Mode Sense 10" packet command was: 
  "5a 00 30 00 00 00 00 00 02 00 00 00 00 00 00 00 "
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Mode Sense 10" packet command was: 
  "5a 00 30 00 00 00 00 00 08 00 00 00 00 00 00 00 "
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid command operation code -- (asc=0x20, ascq=0x00)
  The failed "<NULL>" packet command was: 
  "e9 00 02 00 00 00 00 00 00 00 08 00 00 00 00 00 "
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev 16:00, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in parameter list -- (asc=0x26, ascq=0x00)
  The failed "Mode Select 10" packet command was: 
  "55 10 00 00 00 00 00 00 10 00 00 00 00 00 00 00 "

--Multipart_Sat__2_Nov_2002_18:43:57_-0600_081e4e00
Content-Type: application/octet-stream;
 name="dmesg-stuff"
Content-Disposition: attachment;
 filename="dmesg-stuff"
Content-Transfer-Encoding: base64

c3B1cmlvdXMgODI1OUEgaW50ZXJydXB0OiBJUlE3LgpoZGM6IHBhY2tldCBjb21tYW5kIGVycm9y
OiBzdGF0dXM9MHg1MSB7IERyaXZlUmVhZHkgU2Vla0NvbXBsZXRlIEVycm9yIH0KaGRjOiBwYWNr
ZXQgY29tbWFuZCBlcnJvcjogZXJyb3I9MHg1NAplbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYg
MTY6MDAsIHNlY3RvciAwCkFUQVBJIGRldmljZSBoZGM6CiAgRXJyb3I6IElsbGVnYWwgcmVxdWVz
dCAtLSAoU2Vuc2Uga2V5PTB4MDUpCiAgSW52YWxpZCBmaWVsZCBpbiBjb21tYW5kIHBhY2tldCAt
LSAoYXNjPTB4MjQsIGFzY3E9MHgwMCkKICBUaGUgZmFpbGVkICJNb2RlIFNlbnNlIDEwIiBwYWNr
ZXQgY29tbWFuZCB3YXM6IAogICI1YSAwMCAzMCAwMCAwMCAwMCAwMCAwMCAwMiAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAiCmhkYzogcGFja2V0IGNvbW1hbmQgZXJyb3I6IHN0YXR1cz0weDUxIHsgRHJp
dmVSZWFkeSBTZWVrQ29tcGxldGUgRXJyb3IgfQpoZGM6IHBhY2tldCBjb21tYW5kIGVycm9yOiBl
cnJvcj0weDU0CmVuZF9yZXF1ZXN0OiBJL08gZXJyb3IsIGRldiAxNjowMCwgc2VjdG9yIDAKQVRB
UEkgZGV2aWNlIGhkYzoKICBFcnJvcjogSWxsZWdhbCByZXF1ZXN0IC0tIChTZW5zZSBrZXk9MHgw
NSkKICBJbnZhbGlkIGZpZWxkIGluIGNvbW1hbmQgcGFja2V0IC0tIChhc2M9MHgyNCwgYXNjcT0w
eDAwKQogIFRoZSBmYWlsZWQgIk1vZGUgU2Vuc2UgMTAiIHBhY2tldCBjb21tYW5kIHdhczogCiAg
IjVhIDAwIDMwIDAwIDAwIDAwIDAwIDAwIDA4IDAwIDAwIDAwIDAwIDAwIDAwIDAwICIKaGRjOiBw
YWNrZXQgY29tbWFuZCBlcnJvcjogc3RhdHVzPTB4NTEgeyBEcml2ZVJlYWR5IFNlZWtDb21wbGV0
ZSBFcnJvciB9CmhkYzogcGFja2V0IGNvbW1hbmQgZXJyb3I6IGVycm9yPTB4NTQKZW5kX3JlcXVl
c3Q6IEkvTyBlcnJvciwgZGV2IDE2OjAwLCBzZWN0b3IgMApBVEFQSSBkZXZpY2UgaGRjOgogIEVy
cm9yOiBJbGxlZ2FsIHJlcXVlc3QgLS0gKFNlbnNlIGtleT0weDA1KQogIEludmFsaWQgY29tbWFu
ZCBvcGVyYXRpb24gY29kZSAtLSAoYXNjPTB4MjAsIGFzY3E9MHgwMCkKICBUaGUgZmFpbGVkICI8
TlVMTD4iIHBhY2tldCBjb21tYW5kIHdhczogCiAgImU5IDAwIDAyIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDA4IDAwIDAwIDAwIDAwIDAwICIKaGRjOiBwYWNrZXQgY29tbWFuZCBlcnJvcjogc3RhdHVz
PTB4NTEgeyBEcml2ZVJlYWR5IFNlZWtDb21wbGV0ZSBFcnJvciB9CmhkYzogcGFja2V0IGNvbW1h
bmQgZXJyb3I6IGVycm9yPTB4NTQKZW5kX3JlcXVlc3Q6IEkvTyBlcnJvciwgZGV2IDE2OjAwLCBz
ZWN0b3IgMApBVEFQSSBkZXZpY2UgaGRjOgogIEVycm9yOiBJbGxlZ2FsIHJlcXVlc3QgLS0gKFNl
bnNlIGtleT0weDA1KQogIEludmFsaWQgZmllbGQgaW4gY29tbWFuZCBwYWNrZXQgLS0gKGFzYz0w
eDI0LCBhc2NxPTB4MDApCiAgVGhlIGZhaWxlZCAiTW9kZSBTZW5zZSAxMCIgcGFja2V0IGNvbW1h
bmQgd2FzOiAKICAiNWEgMDAgMzAgMDAgMDAgMDAgMDAgMDAgMDIgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgIgpoZGM6IHBhY2tldCBjb21tYW5kIGVycm9yOiBzdGF0dXM9MHg1MSB7IERyaXZlUmVhZHkg
U2Vla0NvbXBsZXRlIEVycm9yIH0KaGRjOiBwYWNrZXQgY29tbWFuZCBlcnJvcjogZXJyb3I9MHg1
NAplbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgMTY6MDAsIHNlY3RvciAwCkFUQVBJIGRldmlj
ZSBoZGM6CiAgRXJyb3I6IElsbGVnYWwgcmVxdWVzdCAtLSAoU2Vuc2Uga2V5PTB4MDUpCiAgSW52
YWxpZCBmaWVsZCBpbiBjb21tYW5kIHBhY2tldCAtLSAoYXNjPTB4MjQsIGFzY3E9MHgwMCkKICBU
aGUgZmFpbGVkICJNb2RlIFNlbnNlIDEwIiBwYWNrZXQgY29tbWFuZCB3YXM6IAogICI1YSAwMCAz
MCAwMCAwMCAwMCAwMCAwMCAwOCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAiCmhkYzogcGFja2V0IGNv
bW1hbmQgZXJyb3I6IHN0YXR1cz0weDUxIHsgRHJpdmVSZWFkeSBTZWVrQ29tcGxldGUgRXJyb3Ig
fQpoZGM6IHBhY2tldCBjb21tYW5kIGVycm9yOiBlcnJvcj0weDU0CmVuZF9yZXF1ZXN0OiBJL08g
ZXJyb3IsIGRldiAxNjowMCwgc2VjdG9yIDAKQVRBUEkgZGV2aWNlIGhkYzoKICBFcnJvcjogSWxs
ZWdhbCByZXF1ZXN0IC0tIChTZW5zZSBrZXk9MHgwNSkKICBJbnZhbGlkIGZpZWxkIGluIHBhcmFt
ZXRlciBsaXN0IC0tIChhc2M9MHgyNiwgYXNjcT0weDAwKQogIFRoZSBmYWlsZWQgIk1vZGUgU2Vs
ZWN0IDEwIiBwYWNrZXQgY29tbWFuZCB3YXM6IAogICI1NSAxMCAwMCAwMCAwMCAwMCAwMCAwMCAx
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAiCmhkYzogcGFja2V0IGNvbW1hbmQgZXJyb3I6IHN0YXR1
cz0weDUxIHsgRHJpdmVSZWFkeSBTZWVrQ29tcGxldGUgRXJyb3IgfQpoZGM6IHBhY2tldCBjb21t
YW5kIGVycm9yOiBlcnJvcj0weDU0CmVuZF9yZXF1ZXN0OiBJL08gZXJyb3IsIGRldiAxNjowMCwg
c2VjdG9yIDAKQVRBUEkgZGV2aWNlIGhkYzoKICBFcnJvcjogSWxsZWdhbCByZXF1ZXN0IC0tIChT
ZW5zZSBrZXk9MHgwNSkKICBJbnZhbGlkIGZpZWxkIGluIGNvbW1hbmQgcGFja2V0IC0tIChhc2M9
MHgyNCwgYXNjcT0weDAwKQogIFRoZSBmYWlsZWQgIk1vZGUgU2Vuc2UgMTAiIHBhY2tldCBjb21t
YW5kIHdhczogCiAgIjVhIDAwIDMwIDAwIDAwIDAwIDAwIDAwIDAyIDAwIDAwIDAwIDAwIDAwIDAw
IDAwICIKaGRjOiBwYWNrZXQgY29tbWFuZCBlcnJvcjogc3RhdHVzPTB4NTEgeyBEcml2ZVJlYWR5
IFNlZWtDb21wbGV0ZSBFcnJvciB9CmhkYzogcGFja2V0IGNvbW1hbmQgZXJyb3I6IGVycm9yPTB4
NTQKZW5kX3JlcXVlc3Q6IEkvTyBlcnJvciwgZGV2IDE2OjAwLCBzZWN0b3IgMApBVEFQSSBkZXZp
Y2UgaGRjOgogIEVycm9yOiBJbGxlZ2FsIHJlcXVlc3QgLS0gKFNlbnNlIGtleT0weDA1KQogIElu
dmFsaWQgZmllbGQgaW4gY29tbWFuZCBwYWNrZXQgLS0gKGFzYz0weDI0LCBhc2NxPTB4MDApCiAg
VGhlIGZhaWxlZCAiTW9kZSBTZW5zZSAxMCIgcGFja2V0IGNvbW1hbmQgd2FzOiAKICAiNWEgMDAg
MzAgMDAgMDAgMDAgMDAgMDAgMDggMDAgMDAgMDAgMDAgMDAgMDAgMDAgIgpoZGM6IHBhY2tldCBj
b21tYW5kIGVycm9yOiBzdGF0dXM9MHg1MSB7IERyaXZlUmVhZHkgU2Vla0NvbXBsZXRlIEVycm9y
IH0KaGRjOiBwYWNrZXQgY29tbWFuZCBlcnJvcjogZXJyb3I9MHg1NAplbmRfcmVxdWVzdDogSS9P
IGVycm9yLCBkZXYgMTY6MDAsIHNlY3RvciAwCkFUQVBJIGRldmljZSBoZGM6CiAgRXJyb3I6IEls
bGVnYWwgcmVxdWVzdCAtLSAoU2Vuc2Uga2V5PTB4MDUpCiAgSW52YWxpZCBjb21tYW5kIG9wZXJh
dGlvbiBjb2RlIC0tIChhc2M9MHgyMCwgYXNjcT0weDAwKQogIFRoZSBmYWlsZWQgIjxOVUxMPiIg
cGFja2V0IGNvbW1hbmQgd2FzOiAKICAiZTkgMDAgMDIgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDgg
MDAgMDAgMDAgMDAgMDAgIgpoZGM6IHBhY2tldCBjb21tYW5kIGVycm9yOiBzdGF0dXM9MHg1MSB7
IERyaXZlUmVhZHkgU2Vla0NvbXBsZXRlIEVycm9yIH0KaGRjOiBwYWNrZXQgY29tbWFuZCBlcnJv
cjogZXJyb3I9MHg1NAplbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgMTY6MDAsIHNlY3RvciAw
CkFUQVBJIGRldmljZSBoZGM6CiAgRXJyb3I6IElsbGVnYWwgcmVxdWVzdCAtLSAoU2Vuc2Uga2V5
PTB4MDUpCiAgSW52YWxpZCBmaWVsZCBpbiBjb21tYW5kIHBhY2tldCAtLSAoYXNjPTB4MjQsIGFz
Y3E9MHgwMCkKICBUaGUgZmFpbGVkICJNb2RlIFNlbnNlIDEwIiBwYWNrZXQgY29tbWFuZCB3YXM6
IAogICI1YSAwMCAzMCAwMCAwMCAwMCAwMCAwMCAwMiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAiCmhk
YzogcGFja2V0IGNvbW1hbmQgZXJyb3I6IHN0YXR1cz0weDUxIHsgRHJpdmVSZWFkeSBTZWVrQ29t
cGxldGUgRXJyb3IgfQpoZGM6IHBhY2tldCBjb21tYW5kIGVycm9yOiBlcnJvcj0weDU0CmVuZF9y
ZXF1ZXN0OiBJL08gZXJyb3IsIGRldiAxNjowMCwgc2VjdG9yIDAKQVRBUEkgZGV2aWNlIGhkYzoK
ICBFcnJvcjogSWxsZWdhbCByZXF1ZXN0IC0tIChTZW5zZSBrZXk9MHgwNSkKICBJbnZhbGlkIGZp
ZWxkIGluIGNvbW1hbmQgcGFja2V0IC0tIChhc2M9MHgyNCwgYXNjcT0weDAwKQogIFRoZSBmYWls
ZWQgIk1vZGUgU2Vuc2UgMTAiIHBhY2tldCBjb21tYW5kIHdhczogCiAgIjVhIDAwIDMwIDAwIDAw
IDAwIDAwIDAwIDA4IDAwIDAwIDAwIDAwIDAwIDAwIDAwICIKaGRjOiBwYWNrZXQgY29tbWFuZCBl
cnJvcjogc3RhdHVzPTB4NTEgeyBEcml2ZVJlYWR5IFNlZWtDb21wbGV0ZSBFcnJvciB9CmhkYzog
cGFja2V0IGNvbW1hbmQgZXJyb3I6IGVycm9yPTB4NTQKZW5kX3JlcXVlc3Q6IEkvTyBlcnJvciwg
ZGV2IDE2OjAwLCBzZWN0b3IgMApoZGM6IHBhY2tldCBjb21tYW5kIGVycm9yOiBzdGF0dXM9MHg1
MSB7IERyaXZlUmVhZHkgU2Vla0NvbXBsZXRlIEVycm9yIH0KaGRjOiBwYWNrZXQgY29tbWFuZCBl
cnJvcjogZXJyb3I9MHg1NAplbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgMTY6MDAsIHNlY3Rv
ciAwCkFUQVBJIGRldmljZSBoZGM6CiAgRXJyb3I6IElsbGVnYWwgcmVxdWVzdCAtLSAoU2Vuc2Ug
a2V5PTB4MDUpCiAgSW52YWxpZCBmaWVsZCBpbiBjb21tYW5kIHBhY2tldCAtLSAoYXNjPTB4MjQs
IGFzY3E9MHgwMCkKICBUaGUgZmFpbGVkICJNb2RlIFNlbnNlIDEwIiBwYWNrZXQgY29tbWFuZCB3
YXM6IAogICI1YSAwMCAzMCAwMCAwMCAwMCAwMCAwMCAwMiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAi
CmhkYzogcGFja2V0IGNvbW1hbmQgZXJyb3I6IHN0YXR1cz0weDUxIHsgRHJpdmVSZWFkeSBTZWVr
Q29tcGxldGUgRXJyb3IgfQpoZGM6IHBhY2tldCBjb21tYW5kIGVycm9yOiBlcnJvcj0weDU0CmVu
ZF9yZXF1ZXN0OiBJL08gZXJyb3IsIGRldiAxNjowMCwgc2VjdG9yIDAKQVRBUEkgZGV2aWNlIGhk
YzoKICBFcnJvcjogSWxsZWdhbCByZXF1ZXN0IC0tIChTZW5zZSBrZXk9MHgwNSkKICBJbnZhbGlk
IGZpZWxkIGluIGNvbW1hbmQgcGFja2V0IC0tIChhc2M9MHgyNCwgYXNjcT0weDAwKQogIFRoZSBm
YWlsZWQgIk1vZGUgU2Vuc2UgMTAiIHBhY2tldCBjb21tYW5kIHdhczogCiAgIjVhIDAwIDMwIDAw
IDAwIDAwIDAwIDAwIDA4IDAwIDAwIDAwIDAwIDAwIDAwIDAwICIKaGRjOiBwYWNrZXQgY29tbWFu
ZCBlcnJvcjogc3RhdHVzPTB4NTEgeyBEcml2ZVJlYWR5IFNlZWtDb21wbGV0ZSBFcnJvciB9Cmhk
YzogcGFja2V0IGNvbW1hbmQgZXJyb3I6IGVycm9yPTB4NTQKZW5kX3JlcXVlc3Q6IEkvTyBlcnJv
ciwgZGV2IDE2OjAwLCBzZWN0b3IgMApBVEFQSSBkZXZpY2UgaGRjOgogIEVycm9yOiBJbGxlZ2Fs
IHJlcXVlc3QgLS0gKFNlbnNlIGtleT0weDA1KQogIEludmFsaWQgY29tbWFuZCBvcGVyYXRpb24g
Y29kZSAtLSAoYXNjPTB4MjAsIGFzY3E9MHgwMCkKICBUaGUgZmFpbGVkICI8TlVMTD4iIHBhY2tl
dCBjb21tYW5kIHdhczogCiAgImU5IDAwIDAyIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDA4IDAwIDAw
IDAwIDAwIDAwICIKaGRjOiBwYWNrZXQgY29tbWFuZCBlcnJvcjogc3RhdHVzPTB4NTEgeyBEcml2
ZVJlYWR5IFNlZWtDb21wbGV0ZSBFcnJvciB9CmhkYzogcGFja2V0IGNvbW1hbmQgZXJyb3I6IGVy
cm9yPTB4NTQKZW5kX3JlcXVlc3Q6IEkvTyBlcnJvciwgZGV2IDE2OjAwLCBzZWN0b3IgMApBVEFQ
SSBkZXZpY2UgaGRjOgogIEVycm9yOiBJbGxlZ2FsIHJlcXVlc3QgLS0gKFNlbnNlIGtleT0weDA1
KQogIEludmFsaWQgZmllbGQgaW4gcGFyYW1ldGVyIGxpc3QgLS0gKGFzYz0weDI2LCBhc2NxPTB4
MDApCiAgVGhlIGZhaWxlZCAiTW9kZSBTZWxlY3QgMTAiIHBhY2tldCBjb21tYW5kIHdhczogCiAg
IjU1IDEwIDAwIDAwIDAwIDAwIDAwIDAwIDEwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICIK

--Multipart_Sat__2_Nov_2002_18:43:57_-0600_081e4e00--
