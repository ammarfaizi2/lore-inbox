Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWC1S3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWC1S3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 13:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWC1S3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 13:29:16 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:56423 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751173AbWC1S3O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 13:29:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mg2/HfYErQzQ3ONXuaIHY5gqxsB+TY9z59zlAmlIHn/nuEsyYzoAM5bPOMQ6wmY7FfHdu5IVnL6js2TgDajY09vddny+Y0E8KPtt4w8byvhVwxwFWDBBvnzcSmm9/oukl0zRFuMJefWMn8kQzl3rPAEnL7f01XPLaoAcjQvzNyM=
Message-ID: <9a8748490603281029u63d785f8pd5f499baab86f98a@mail.gmail.com>
Date: Tue, 28 Mar 2006 20:29:13 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: gene.heskett@verizononline.net
Subject: Re: Possible breakage in 2.6.16?
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
In-Reply-To: <200603281244.24906.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603281244.24906.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/06, Gene Heskett <gene.heskett@verizon.net> wrote:
> Greetings;
>
> Always curious as to what sort of information can be extracted from the
> tools linux gives us, I've discovered that netstat, from the
>
> net-tools-1.60-25.1 rpm
>
> no longer functions for anything as even a 'netstat --version' takes the
> curser to the upper left corner of the screen and hangs till ctl+c'd.
>
> The only evidence of its execution is a steady, about 2 per second,
> increase in the number of processes running as reported by gkrellm, all
> of which go away when I ctl+c netstat itself.
>
> I'm running 2.6.16 self configured here.
>
> Is this a known problem because my net-tools rpm is old?  Or because
> 2.6.16 broke it?
>

I'm not running 2.6.16 here, but 2.6.16mm1  but anyway, netstat seems
to work quite nicely :

juhl@dragon:~$ cat /etc/slackware-version
Slackware 10.2.0
juhl@dragon:~$ uname -a
Linux dragon 2.6.16-mm1 #1 SMP PREEMPT Sun Mar 26 14:01:58 CEST 2006
i686 athlon-4 i386 GNU/Linux
juhl@dragon:~$ netstat --version
net-tools 1.60
netstat 1.42 (2001-04-15)
Fred Baumgarten, Alan Cox, Bernd Eckenfels, Phil Blundell, Tuan Hoang and others
+NEW_ADDRT +RTF_IRTT +RTF_REJECT +FW_MASQUERADE +I18N
AF: (inet) +UNIX +INET +INET6 +IPX +AX25 +NETROM +X25 +ATALK -ECONET -ROSE
HW:  +ETHER +ARC +SLIP +PPP +TUNNEL +TR +AX25 +NETROM +X25 +FR -ROSE
-ASH -SIT -FDDI -HIPPI -HDLC/LAPB -EUI64
juhl@dragon:~$ netstat -anp
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address        
State       PID/Program name
tcp        0      0 0.0.0.0:6000            0.0.0.0:*              
LISTEN     -
tcp        0      0 0.0.0.0:80              0.0.0.0:*              
LISTEN     -
tcp        0      0 0.0.0.0:22              0.0.0.0:*              
LISTEN     -
tcp        0      0 0.0.0.0:631             0.0.0.0:*              
LISTEN     -
tcp        0      0 192.168.1.34:47442      xxx.xxx.xxx.xxx:443       
ESTABLISHED2582/firefox-bin
tcp        0      0 192.168.1.34:47439      xxx.xxx.xxx.xxx:443       
ESTABLISHED2582/firefox-bin
tcp        0      0 192.168.1.34:57388      xxx.xxx.xxx.xxx:995      
TIME_WAIT  -
[snip rest of output]


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
