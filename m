Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTDNKO3 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 06:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbTDNKO2 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 06:14:28 -0400
Received: from [195.82.114.197] ([195.82.114.197]:58375 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id S262942AbTDNKO1 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 06:14:27 -0400
Date: Mon, 14 Apr 2003 11:26:13 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Russell Nash <russ@nixhelp.org>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: PROBLEM: mkdir on ext3 creates regular file instead of
 directory
Message-ID: <507920461.1050319573@[192.168.100.8]>
In-Reply-To: <3E9A19D7.6040509@nixhelp.org>
References: <3E9A19D7.6040509@nixhelp.org>
X-Mailer: Mulberry/2.2.1 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [1.] One line summary of the problem:
>
> when using 'mkdir' to create a directory on an ext3 filesystem, a regular
> file is created instead of the directory.

Had you by any chance done something a little like this
(which can produce similarly odd results - not sure about
quite the same ones).

Shell 1					Shell 2
=======					=======

cd ~
					cd ~
mkdir foo
cd foo
					rmdir foo
mkdir .variable


Or more confusingly



Shell 1					Shell 2
=======					=======

cd ~
					cd ~
mkdir foo
cd foo
					rmdir foo
					mkdir foo
mkdir .variable



--
Alex Bligh
