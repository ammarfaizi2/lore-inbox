Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136256AbREDLhw>; Fri, 4 May 2001 07:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136249AbREDLhm>; Fri, 4 May 2001 07:37:42 -0400
Received: from penguins-world.pcsystems.de ([212.63.44.200]:20206 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S136189AbREDLha>;
	Fri, 4 May 2001 07:37:30 -0400
Message-ID: <3AF29464.885B7F13@pcsystems.de>
Date: Fri, 04 May 2001 13:37:08 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: added a new feature: disable pc speaker
Content-Type: multipart/mixed;
 boundary="------------1FFEBE6FF45EEEA06EA0F4D3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1FFEBE6FF45EEEA06EA0F4D3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi guys!

I have searched a long time for a method to disable the internal
speaker for every application, every daemon and so on.
With the help of [] I have found the right file :

drivers/char/vt.c

Now I have made some changes to this file (from 2.4.4 kernel).
I wanted to ask you whether you can/will put this feature into the next
kernel release (f.i. 2.4.5).
Below is a description of what I did, hope I changed the right
files and didn't brake any kernel structure...
That's also the reason I don't send a config.in diff.

Regards,

Nico


1. Changed vt.c (diff attached)
2. Changed arch/{i386,alpha,ppc,arm,mips}/config.in :

if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
   bool '  Disable the PC-Speaker' CONFIG_DISABLE_PC_SPEAKER
fi

(should be the last item of the 'General Setup' Menu)

3. Changed init/main.c (diff attached)
4. wrote text for Configure.help:

-------------------------------------------------------------------------

Disables the Internal (PC) speaker
CONFIG_DISABLE_PC_SPEAKER
  Whenever you don't want your computer to be able to beep,
  choose this option. Not selected, the computer will be able
  to beep.

  Attention: This will not catch the beeps made directly by the
  BIOS (mostly this happens when using a notebook and pressing
  special key codes). To disable this "BIOS-beep" enter the
  BIOS and change it there.

  If you are unsure, say N to this.

-------------------------------------------------------------------------

If you allow this thing to get into the kernel, could
Axel Bold (axel@uni-paderborn.de as found in Configure.help)
put this text into the Configure.help file ?



--------------1FFEBE6FF45EEEA06EA0F4D3
Content-Type: application/x-gzip;
 name="diffs.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="diffs.tar.gz"

H4sIAOqT8joAA+1WbW8iNxDOV/gV0zspgeMlLLBQaHSCBJKgvCqgqyqdZBmvAYtde+X1kkt7
/e8d70LSXKqrqvbSVvKjlWyNPePH9viZjaiQJKaGrfa+GRpeo9Fpt/caiG4nbxG71mu1mnuN
brPb9j2v5WPf8/xuZw8a347SE9LEUA2wJwVTX5unlTKvweeVUavVIMIcqLOa0mJZONUCrugD
QBsajb79fGjiHRUrlcp2YmG2SvM5LWi2+n6v73XyOYMB1LrVDlS61S4MBkWAdwDDIOABCCmM
DmAf2IrKJSf2OPvwI9eSaxiGEU/mXC+xvw/nVCZwyXXEZRVO+RwOep081JWiEjjV4QOIBSwZ
A5GACoMq0I0SgZBLmKtlmsDaxg0TqMEtTUM4U9pEFI3VjPdjvKmI4lAsBPKzWWBsALXIuPZx
NYFceQjDOpxpsVgIs4KjJfYGlEV1pZfvoVixYWi2w4NAJHQeYi9mScztcgeA+0rokiMRm1+D
hK2UMTwUaWIDoNnyyc4OCR0WoQhvA74QkgMhF+O76/Elmf40PRleXk4Jyc7X9z17wr7frHqN
7JAL64hHhFG24sRSL5V/QGNiRN5hNBRzTQ0nAQ/pgzVW3ooFLgMnN9enkzMymkyHx5djcntC
prfjIa5brBRiLaRZl95MpMHDpCFs9wQluqYAtyc7Qxl2G/8o32TBuQzEoljBvTxb5vjygozG
H8jkejK7GyEzvMNSnhckO37Y34fvtoY5D9V9biZqjSM4v1B4NvsIItQuOy1eSDg6gtvh2ZhM
zyenszL8Uvy3X9b/AxvzrdX/T/W/2fD9R/1H5bf63/I8p/+vAav/G5Np/3Nl99p9v9X3Wk/q
vzEvtL/t99tf0/7Rg6SRYKjHDxGNgUortNrKLA1DxagRSqIIUj4fsHtRl+FWEb1er51HuOPW
gRn4MIPkXmCmWu+NoCAUM2GpjB6ZJrOknjJd50GKlhFnNoa/lXkVcWAq4BCpDerzQmkIUZhz
W5BiDXikMkTtgouQc5lR0TZMN5f5vJDRuQiFeQCjdroHZsVR8x8F8i9ovZAsTJHDUShk+umQ
KbnAe1i9z06z16r2oNJr73QeOTAVYVU0trBdjK4uZjfXYwgUT+SBgTg1OROtmN0cEkxwH3F9
t1wN5Rjy6hKUCBGt7zuElOHz598ZaRiv6AtrrO65jpm1f8yKB5T+gUBggcOlp/FIxIkdtIVg
Z91Wj+nZhExum82yda29dKU62np+4Xh+M52R05ub2fHdZHQ2LpfxNv+GN2z9/4DiyzpatreM
AmPwDdg/lCKsAyJVolIZlFKZiCW6Q6gwpbGrNA/K2dV7LfuKKl6rt31MBc1NqiXW81+zm8Sf
G24rLTZw+A6yFv9cImrfByb7irM1HG4z1L6YXXLmiZdzIUgmWn9BBqs+rH6uwjMD8l8nZVdS
HRwcHBwcHBwcHBwcHBwcHBwcHBwcHBwcHBz+2/gN1IlxkwAoAAA=
--------------1FFEBE6FF45EEEA06EA0F4D3--

