Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312480AbSEMLWG>; Mon, 13 May 2002 07:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSEMLWF>; Mon, 13 May 2002 07:22:05 -0400
Received: from [203.200.51.170] ([203.200.51.170]:25070 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S312480AbSEMLWE>; Mon, 13 May 2002 07:22:04 -0400
Message-Id: <200205131138.g4DBcU526690@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII
From: rpm <rajendra.mishra@timesys.com>
Reply-To: rajendra.mishra@timesys.com
Organization: Timesys
To: linux-kernel@vger.kernel.org
Subject: ADS GCP reboots when running the application!
Date: Mon, 13 May 2002 17:08:30 +0530
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
   I am using  "2.4.9-ac10-rmk2-np1-ads3"  kernel on ADS Graphic Client Board 
(StrongARM). When i run the following c++  code the system reboots. 

************************************************************************
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
**********************************************************************
Here, "input.out" is a file containing 10000 numbers. If the numbers in the 
file "input.out" are 5000 then the system works fine. 
    The kernel is not showing any OOPS or panic  , it just reboots ! what i 
think is that some double fault ( fault inside fault handler ) or  something 
similar to that might be causing the precessor to reboot. Can someone  give 
some direction  !

regards,
rpm

ps: I am not attaching the "input.out" file due to large size if some wants 
to test , i can send the file !

