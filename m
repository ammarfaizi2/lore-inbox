Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132895AbRDJB4a>; Mon, 9 Apr 2001 21:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132893AbRDJB4U>; Mon, 9 Apr 2001 21:56:20 -0400
Received: from mail.kasenna.com ([63.206.76.4]:21735 "HELO kasenna.com")
	by vger.kernel.org with SMTP id <S132894AbRDJB4N>;
	Mon, 9 Apr 2001 21:56:13 -0400
Message-ID: <3AD26831.9DAA0BDE@kasenna.com>
Date: Mon, 09 Apr 2001 18:56:01 -0700
From: Ram Madduluri <ram@kasenna.com>
Reply-To: ram@kasenna.com
Organization: Kasenna Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-0.99.11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ram@kasenna.com
Subject: Increasing the FD_SETSIZE
Content-Type: multipart/mixed;
 boundary="------------38EC8CA98F6EE3B25E6578E9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------38EC8CA98F6EE3B25E6578E9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I am having trouble with increasing the file descriptor size for my
application - it opens several files for each client session (and needs
to keep them open as long as the session is active, which can be upto 3
hours long). What I see from the application is "open failed in
FileStreamReader::setupFile: Too many open files".

I have bumped up /proc/sys/fs/file-max to 16K, but I am failing at  2638
(cat /proc/sys/fs/file-max returns "2638 97 16384") when the number of
files my app opened reached 1023.

There is a comment in /usr/include/linux/posix_types.h regarding
__FD_SETSIZE being set to 1024. How can I increase this value?

Thanks,
Ram Madduluri

--------------38EC8CA98F6EE3B25E6578E9
Content-Type: text/x-vcard; charset=us-ascii;
 name="ram.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Ram Madduluri
Content-Disposition: attachment;
 filename="ram.vcf"

begin:vcard 
n:Madduluri;Ram
x-mozilla-html:FALSE
url:http://www.kasenna.com
org:Kasenna Inc
adr:;;;;;;
version:2.1
email;internet:ram@kasenna.com
x-mozilla-cpt:;864
fn:Ram Madduluri
end:vcard

--------------38EC8CA98F6EE3B25E6578E9--

