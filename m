Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbUDDPgt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 11:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUDDPgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 11:36:49 -0400
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:43139 "EHLO
	longlandclan.hopto.org") by vger.kernel.org with ESMTP
	id S262427AbUDDPgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 11:36:45 -0400
Message-ID: <40702B87.6080506@longlandclan.hopto.org>
Date: Mon, 05 Apr 2004 01:36:39 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Who maintains the atp870u driver? (ACARD PCI SCSI)
X-Enigmail-Version: 0.82.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020403040507090107080906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020403040507090107080906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi All,
	Does anyone still maintain the atp870u SCSI driver, and if so, is it
possible for them to contact me?  I had a look in the atp870u.c file --
if I read this correctly, this driver hasn't changed much in the last
few years.  (Last log entry was in 2001).

	Basically, I recently acquired a PCI ACARD SCSI card (can't recall what
chipset exactly) and decided to use that in a Gateway Microserver server
appliance I had laying around.  The intent was to plug it into an
external tower of hard drives to make a nice compact fileserver for lans.

	The machine is a clone of the Cobalt Qube 2 (2800) server appliance,
running a 250MHz (?) MIPS "Nervada" R5200 CPU, 64MB EDO RAM, and 10GB
IBM IDE HDD internal.  It has one PCI slot, attached to a Galileo PCI
controller.  When first bought, it had a Lucent Winmodem installed
(Gateway branded).  All I've done is simply replaced the modem with this
SCSI card.  The box is running Debian 3.0 with Linux Kernel 2.4.24-pre2
(from linux-mips CVS).

	If I fire the box up, then run 'modprobe atp870u' -- with no devices
attached (or switched off), the driver loads, no worries.  However, if I
try doing the same with a device attached (and switched on), I get SCSI
timeout errors, and the driver initialisation stalls. -- I have to
reboot to unload the driver. (See attachment)

	The device in question is the tower of hard drives I mentioned above
(has 3x 18.2GB and 1x 9.1GB HDDs).  I know from previous testing that
neither the tower, the cable nor the terminator are at fault -- they
work just fine on both an SGI Indy and my main machine (with an Advansys
SCSI card) without any hassles.  I have also tried plugging in an
external tape drive, and got the same results.

	The only thing that I haven't tested is whether the card works (it was
sold second hand with a CDRW burner -- I presumed it did, and from the
tests tonight, there's at least a little bit of life), and what its
compatability is with Linux (in particular Linux/MIPS).  I've also tried
an Advansys SCSI card (the one in my main box) in the same machine with
no joy (it didn't work _at all_ -- so the ACARD host is currently doing
better right now)

	I'm not able to hack the driver myself, as I'm a newbie when it comes
to kernel hacking. (Otherwise I'd be looking into it right
now...unfortunately I'm a C newbie, and therefore the code is right over
my head.)  I might also later try the Linux-MIPS crew if this turns out
to be a MIPS-specific thing (I can't rule that one out).

Any assistance would be appreciated,
- --
+-------------------------------------------------------------+
| Stuart Longland           stuartl at longlandclan.hopto.org |
| Brisbane Mesh Node: 719             http://stuartl.cjb.net/ |
| I haven't lost my mind - it's backed up on a tape somewhere |
| Atomic Linux Project    <--->    http://atomicl.berlios.de/ |
+-------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAcCuHuarJ1mMmSrkRAsUHAJ9gyP5C/rGCes54tKVY4PC2V155fwCcCWMT
nDLFI1+sAvydOfNoRQVT2J8=
=L26G
-----END PGP SIGNATURE-----

--------------020403040507090107080906
Content-Type: application/gzip;
 name="qube_scsi_log.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="qube_scsi_log.txt.gz"

H4sICHQgcEACA3F1YmVfc2NzaV9sb2cudHh0AL1XYW/bNhD9rl9xQIA12WKJlGzL1tABbuw1
HuKki5O2QVEUlETZRGhJJakk/rLfviOdtImbus62TEgc27x79+7u8cjsEpK0O3uQcqYNDKus
WfDSMCOqEnZA6zl8blLuHdlVWc1EmcAElwa1AuiAc05IH0JC2lCoagG0H/q02/OJTwENa6MD
6h2JsrlxSBD6bT9st2rFw9ZC1Dq70i3rTbqEwg4NYcoM/MFKiCjQTtKOkiiG0fRsFcJ6QFNe
ltV16XmTCllVBZg5h1pVM8UWGkSZySbnOVwLM3dLQ54KBHx9fB6siOilNnwBTHGvUJzLJSie
C22USBvDUsl/dX78hmUGvizYkhiuMERRKeAsm98F9RAJcq4ztMPAonTuoszFlcgbJqEQkltm
EDRaBXqO9kFeZcHPQVbVSyVmc+N539DMqgV6uTQGr6YnR+dno6MLOD6Bd4PT08Hx2cU+mOqW
qcGueTWyE8YghXQJrK6lyGw2INm1/89a6NmeJX/tgGFCQquA4IqpAFECpKbZDPn95H2gH6Hd
/2p7D7mb0HjV90uuSi4T4GZOEhiKmTBYmOE0pLQdwVkjRY1duIJuB1AA5IYS++xbFEqSEUnw
Ta+bRMN9GJ/+CW3f2xjmzcE4gVGJ6Ytyhr25Ehm3piTzCewicgdav+EXJN7bDGQsM5rAicxt
3xdIbjR6c3oysep+cVClTBqYiExVU66uuHoBacVU7gOcaxtaN6k2wjSGwwJFxrCrpVGVRDUU
lb9d7LuIOS9Yg+FWQGZZcxg0ptK81HxbqHGZ8xvYIdCCiYOZjMewu0Pp3j0FW/mA7Uzolt8c
XsBuhENCVtnltoGso1Gs1BkXWBfc2zb1QszAthY0DplGQ9xD6bEcDYxw9SKU0x+EQAnR7SRE
v5VQnAx+X0mIRj+Og1KdcmMssaKRspU3tcTypUxjlVAAmCTmhRq7hJopU2KeGatZKqQwSzua
2p1t0nmWMP1VGFnnH0LS/phgbbDoCseD92WrLqocZxhaMVP3YtI8tofjhEYPGU8PpmMn7NUc
zZVr8CluMo1DMgHqE+JtRGA868b05lPODc9MstkYn8HB4HQIg9FBC93e290N5xLVFbxzZFoR
HNqzYJCzGkd0AsQ6jU+w7z0nAex30vd/GGb1jIf4IYYHkJtddaYFgeQhTRLgS2hfuuQ+4+Do
7fCO9S06DFclfBv63V9Y9rU/aoEd2tyckHzLBWwF5khfg+SF8b/f74dQ3Sd0ad34mbr0SJh7
XUKE8auJ+zx8fziFew9pR+QpUBRgOhq8HpyNYPqe0l4YR0cHq/Vu1I2fAhV+H6oT98OnQEUP
oPo0pu/u1vvD6ElQGxW97vpfK/pBsCh8VLIsrZSbgXjxWbAyh7zh7oYjFrxqDFrUIod4f0Vu
H7I5K9Ef8C1+j6+yKVEROPhDDHT7UxSwPozWw4OK0pfhZqO1xd4awmdkmuXpS5RRCE6Wd78Y
3/2VeP36JHnZvLTn3/+ecm+blHvPmrI7NexQwjWXN+y65PZctnjOYb4te0itTsLN4R1YihcI
ofF/F1tB5+iu5rcxvtTK3wJq3ecW7jGGRi1tPLzE5+u76N+x/BtFJhIhjA0AAA==
--------------020403040507090107080906--
