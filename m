Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292586AbSBTXeR>; Wed, 20 Feb 2002 18:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292583AbSBTXeI>; Wed, 20 Feb 2002 18:34:08 -0500
Received: from ns3.efi.com ([192.68.228.85]:12050 "HELO fcexgw02.efi.internal")
	by vger.kernel.org with SMTP id <S292582AbSBTXdu>;
	Wed, 20 Feb 2002 18:33:50 -0500
Message-ID: <3C7433F8.8FB86B39@efi.com>
Date: Wed, 20 Feb 2002 15:40:40 -0800
From: Kallol Biswas <kallol@efi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: lseek SEEK_END fails on a Toshiba 6007MB disk.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <unistd.h>



main(int argc, char *argv[])
{
int fd;
int offset;
int loffset;

fd = open("/dev/hda", O_RDONLY);

if (fd < 0) {
        perror("open");
        return;
}

offset = lseek(fd, 0, SEEK_END);

if (offset < 0) {
        perror("lseek");
}

}


# ./seek
lseek: Value too large for defined data type

The system runs 2.4.17 kernel.

A fix may be found reading the source code, but if someone already knows

the solution, please reply  to me.

Kallol

