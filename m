Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267618AbSLNNxj>; Sat, 14 Dec 2002 08:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267619AbSLNNxi>; Sat, 14 Dec 2002 08:53:38 -0500
Received: from 195-219-31-160.sp-static.linix.net ([195.219.31.160]:10112 "EHLO
	r2d2.office") by vger.kernel.org with ESMTP id <S267618AbSLNNxh>;
	Sat, 14 Dec 2002 08:53:37 -0500
Message-ID: <3DFB3983.3090602@walrond.org>
Date: Sat, 14 Dec 2002 14:00:35 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@bradfords.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
References: <200212141355.gBEDtb7q000952@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, typo - thanks John.

Trying again...

(contrived example with made-up mount option --overlay)

mkdir a
echo "a/x" > a/x
echo "a/y" > a/y
echo "a/z" > a/z

mkdir b
echo "b/y" > b/y

mkdir c
echo "c/z" > c/z

mkdir d
mount --bind a d
mount --bind --overlay b d
mount --bind --overlay c d

cat d/x
"a/x"

cat d/y
"b/y"

cat d/z
"c/z"

