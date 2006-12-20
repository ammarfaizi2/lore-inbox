Return-Path: <linux-kernel-owner+w=401wt.eu-S964915AbWLTGfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWLTGfA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 01:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWLTGfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 01:35:00 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:44983 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964915AbWLTGe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 01:34:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=q5mKBddsn694nJ1z8YoIExbNRXXfFmLU1vyoMRPdLJT0GBddYqEcvNuil5okS4BENz7ncGX99vN3ZebO7OVTgQsoeuh8IflW+X8t9HSV+F+0JQv6viDljzFKY2ZzU7CvLOQsAKb5I8RZtyXM1wbJsnZxVa0r1VRk9VWgVi+1rJU=
Message-ID: <66a17a7e0612192234o7a66668et58c11afd131c3554@mail.gmail.com>
Date: Wed, 20 Dec 2006 01:34:59 -0500
From: "meta link" <m3talink@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: downloading kernels w/ metalink (mirrors, checksums, signatures)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This may not be as nice for kernels as for other downloads because of
how nicely organized the kernel mirrors are, but maybe some people
will be interested.

Metalink is a system which attempts to improve the download process by
increasing availability and guaranteeing integrity. It can give your
users a more reliable download by providing multiple links to the same
file, which can be switched to if one server is down or fails during
transmission. It can also make downloads faster by using multiple
resources at once.

Metalink lists mirrors with machine readable information on priority
and location so their efficient use can be automated by download
programs. It can list mirrors around the world, but will automatically
default to mirrors closer to you and by priority. The checksum
verification process, usually manual and arcane to most people, is
automated with Metalink, so files are guaranteed to be an exact copy
of the file you downloaded, free of errors. Metalinks can also contain
publisher information, Operating System and architecture, language,
file descriptions, mutliple files (to be added to a download queue),
partial file checksums, and so on. All this extra information allows
download programs to do interesting things.

Linux Kernel Metalink downloads (All):
http://download.packages.ro/metalink/kernel/
More details..."Downloading bliss with Metalink":
http://www.linux.com/article.pl?sid=06/11/01/1641247

Partial example .metalink:

<?xml version="1.0" encoding="UTF-8"?>
<metalink version="3.0" xmlns="http://www.metalinker.org/"
  origin="http://prog.infosnel.nl/metalinks/kernel.php/kernel/v2.6/linux-2.6.19.tar.bz2.metalink"
  generator="http://prog.infosnel.nl/metalinks/kernel.php">
  <publisher>
  	<name>Kernel.org</name>
  	<url>http://kernel.org/</url>
  </publisher>
<files>
	<file name="linux-2.6.19.tar.bz2">
        <version>2.6.19</version>
		<verification>
                  <hash type="md5">443c265b57e87eadc0c677c3acc37e20</hash>
			<signature type="pgp" file="linux-2.6.19.tar.bz2.sign" />
		</verification>
		<resources>
			<url type="http" location="al"
preference="10">http://www.al.kernel.org/pub/linux/kernel/v2.6/linux-2.6.19.tar.bz2</url>
			<url type="ftp" location="al"
preference="20">ftp://ftp.al.kernel.org/pub/linux/kernel/v2.6/linux-2.6.19.tar.bz2</url>
			<url type="http" location="aq"
preference="10">http://www.aq.kernel.org/pub/linux/kernel/v2.6/linux-2.6.19.tar.bz2</url>
			<url type="http" location="ag"
preference="10">http://www.ag.kernel.org/pub/linux/kernel/v2.6/linux-2.6.19.tar.bz2</url
		</resources>
	</file>
	<file name="linux-2.6.19.tar.bz2.sign">
		<resources>
			<url type="http" location="al"
preference="10">http://www.al.kernel.org/pub/linux/kernel/v2.6/linux-2.6.19.tar.bz2.sign</url>
			<url type="ftp" location="al"
preference="20">ftp://ftp.al.kernel.org/pub/linux/kernel/v2.6/linux-2.6.19.tar.bz2.sign</url>
			<url type="http" location="aq"
preference="10">http://www.aq.kernel.org/pub/linux/kernel/v2.6/linux-2.6.19.tar.bz2.sign</url>
			<url type="http" location="ag"
preference="10">http://www.ag.kernel.org/pub/linux/kernel/v2.6/linux-2.6.19.tar.bz2.sign</url>
		</resources>
	</file>
</files>
</metalink>

A real .metalink would list all mirrors.

Metalink is supported by download managers on Mac, Unix, and Windows.

aria2 ( http://aria2.sourceforge.net/ ) is a really nice command line
client. You can use command line options to default to mirrors in a
certain country (--metalink-location=XX) and other things.

The main users of metalink are OpenOffice.org, openSUSE, Arch Linux,
and other Linux distributions for ISO downloads.

(( Anthony Bryan
 )) Metalink [ http://www.metalinker.org ]
