Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313114AbSEMMAq>; Mon, 13 May 2002 08:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313163AbSEMMAq>; Mon, 13 May 2002 08:00:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6786 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313114AbSEMMAo>; Mon, 13 May 2002 08:00:44 -0400
Date: Mon, 13 May 2002 08:02:20 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: c++ program reboots system.
Message-ID: <Pine.LNX.3.95.1020513075608.19504A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I didn't save the address of the person who reported the reboot
error...
This c++ code was reported to reboot a machine.

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <iterator>
using namespace std;
int main(int argc, char** argv)
{
    string raw_filename = "input.out";
    ifstream raw_file(raw_filename.c_str());
    vector<long> data;
    copy(istream_iterator<long>(raw_file),istream_iterator<long>(),back_inserter(data));
    data.erase(data.begin());
    return 0;
}
Script started on Mon May 13 07:51:12 2002
# gdb xxx
GDB is free software and you are welcome to distribute copies of it
 under certain conditions; type "show copying" to see the conditions.
There is absolutely no warranty for GDB; type "show warranty" for details.
GDB 4.15 (i586-unknown-linux), Copyright 1995 Free Software Foundation, Inc...
(gdb) run
Starting program: /root/xxx 

Program received signal SIGSEGV, Segmentation fault.
ostream::flush (this=0x8c224) at iostream.cc:864
864	    if (_strbuf->sync())
(gdb) quit
The program is running.  Quit anyway (and kill it)? (y or n) y
# exit
exit
Script done on Mon May 13 07:51:49 2002

On Linux 2.4.18, the program just seg-faults (as it should).
On the version you are using, you should write a 'C' program
that does lseek() beyond EOF. There could be a bug there, but
otherwise I can't tell from the program presented.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

