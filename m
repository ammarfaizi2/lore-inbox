Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311433AbSDDUFU>; Thu, 4 Apr 2002 15:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311454AbSDDUFI>; Thu, 4 Apr 2002 15:05:08 -0500
Received: from sitar.i-cable.com ([210.80.60.11]:1940 "HELO sitar.i-cable.com")
	by vger.kernel.org with SMTP id <S311433AbSDDUE4>;
	Thu, 4 Apr 2002 15:04:56 -0500
Message-ID: <3CACB1DD.2040508@shaolinmicro.com>
Date: Fri, 05 Apr 2002 04:04:45 +0800
From: David Chow <davidchow@shaolinmicro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: vcd, .dat files and isofs problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have problems reading the .dat files from VCD, here is the kernel 
logs. I think it is an fs issue, since I am not the only one having the 
same problem. In user space, read returns I/O error but I think it is an 
fs issue or a cd-rom
driver issue, I have tested with xine vcd player, the vcd can be played 
by directly accessing the block device but not through the fs. I tested 
the VCD under MS Windows using the same machine and disc and .dat files 
can be correctly read, even  I use vcdgear win32 to convert the .dat 
file to .mpg it is still fine. So it is sure it is not the CD or 
hardware problem.

Many VCD's are tested and result is the same. It is likely to be an fs 
specific problem. I am running 2.4.17 and lsmod shows isofs is in use. 
Here is my log messages.

kernel: hdd: command error: error=0x55
kernel: end_request: I/O error, dev 16:40 (hdd), sector 32300
kernel: hdd: command error: status=0x51 { DriveReady SeekComplete Error }
kernel: hdd: command error: error=0x55
kernel: end_request: I/O error, dev 16:40 (hdd), sector 32304
kernel: hdd: command error: status=0x51 { DriveReady SeekComplete Error }
kernel: hdd: command error: error=0x55
kernel: end_request: I/O error, dev 16:40 (hdd), sector 32308
kernel: hdd: command error: status=0x51 { DriveReady SeekComplete Error }
kernel: hdd: command error: error=0x55
kernel: end_request: I/O error, dev 16:40 (hdd), sector 32312
kernel: hdd: command error: status=0x51 { DriveReady SeekComplete Error }
kernel: hdd: command error: error=0x55
kernel: end_request: I/O error, dev 16:40 (hdd), sector 32316
kernel: hdd: command error: status=0x51 { DriveReady SeekComplete Error }

regards,

David

