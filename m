Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318241AbSG3MM1>; Tue, 30 Jul 2002 08:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318242AbSG3MM1>; Tue, 30 Jul 2002 08:12:27 -0400
Received: from boden.synopsys.com ([204.176.20.19]:12031 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S318241AbSG3MM0>; Tue, 30 Jul 2002 08:12:26 -0400
Date: Tue, 30 Jul 2002 14:15:39 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Testing of filesystems
Message-ID: <20020730121539.GA20781@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: JFS-Discussion <jfs-discussion@www-124.ibm.com>,
	linux-kernel@vger.kernel.org
References: <20020730094902.GA257@prester.freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020730094902.GA257@prester.freenet.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 11:49:02AM +0200, Axel Siebenwirth wrote:
> Hi,
> 
> I wonder what a good way is to stress test my JFS filesystem. Is there a tool
> that does something like that maybe? Dont't want performance testing, just
> all kinds of stress testing to see how the filesystem "is" and to check
> integrity and functionality.
> What are you filesystem developers use to do something like that?

while sleep 1; do

for i in `seq 1 100`; do
    dd if=/dev/zero of=f$i bs=$(( $i * 100 )) count=$(( $i * 10 ))
done
cat * >/dev/null
rm *
make -C dummy-kernel dep bzImage modules -j2

done
