Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317743AbSHPAqb>; Thu, 15 Aug 2002 20:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317751AbSHPAqa>; Thu, 15 Aug 2002 20:46:30 -0400
Received: from imo-m05.mx.aol.com ([64.12.136.8]:19407 "EHLO
	imo-m05.mx.aol.com") by vger.kernel.org with ESMTP
	id <S317743AbSHPAqa>; Thu, 15 Aug 2002 20:46:30 -0400
Message-ID: <3D5C14B4.1090706@netscape.net>
Date: Thu, 15 Aug 2002 20:53:08 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: greg@kroah.com, Patrick Mochel <mochel@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: driverfs: driver interface
References: <3D5AD6BF.8060609@netscape.net> <20020815050419.GB30226@kroah.com> <3D5B885E.5000407@netscape.net> <20020815162308.GC32542@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------040105040101060204080409"
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------040105040101060204080409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



greg@kroah.com wrote:

>
>But a PCI bus could also be present, with a USB controller, and the hid
>driver would be able to handle devices on it too.  So how would you show
>this "dual" relationship then?
>
Good point.

Check this out.  Rather than explaining it, I've attached it to this 
email.  It might solve this problem.  It's based on an idea I stated 
earlier.  I haven't quite worked out the details yet and I'm not really 
even sure if it's the best thing to do.  I created a sample interface 
comprised of folders and links and then tarred and gzipped it.  I'm 
looking forward to some reactions on it. (look in ./driver)

Also I have two questions:

1.)  Is it worth it to remove the bus interface?
my answer:    I think it is because an interface in which drivers can 
have children is far more flexable and scaleable.  Also it would result 
in less code.  I'm looking for some feedback so I can revise my current 
efforts.

2.) Should driver management occur through driver model interfaces?
my answer:    I already have the code to do this, it's just a matter of 
what's the best way to manage drivers.  I feel that the driver model is 
the best place because it offers the most flexability and it allows for 
control over all drivers, not just modules.

Thanks,
Adam

PS: I'm currently working on a patch that just implements the read for 
"driver" as discussed earlier.


--------------040105040101060204080409
Content-Type: application/octet-stream;
 name="driverfs.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="driverfs.tar.gz"

H4sICMoOXD0AA3RlbXBfdGFydzlFN25iLnRhcgDtm92OmzAQRvMoeYFu/e/nISGbRUoVBEnV
ffvamGwb7FQdaTA337mBCyQ7Oh7PjCHt0P08De/j9916CGGEtzZchfRWxmvkcU333irnvZHW
7YSUxqvd3q44py/u460Z9vtd8+PwS/7jueF6vdWYT2Xah//4+1ZaBAT/1mkf/Cvj4L8Kz/77
Yyf4FwHNvwr+tZYC/mvw7H/8XCMR0ONfawH/Vfjyn25WyQAU/1bH/K+8h/8qLP2/X659/8m7
DCj+Y+IX0oQFAP81WPq/9Jvmf+OMifu/Eaj/qrD035z7czPwdgKk/V9M8W+Eg/8aLP1/dC37
BkDyr2yMf6sR/1VY+u+bob9uF//GOTnFf3gc/ivwyv+l5xsj1PPCh4Lu//1b60L9r97eWOdR
BP6L/rv2xDYGyb+O9Z8T4TL555xHEfh/8r/GCRAl/4cnYv53OP+pQ8l/OgPgG4MQ/7N/Z2L/
H+Ofey4Z8J/5n3MA2xgk/yLmfy/UvP9zzyUD/jP/42nomgvfGJT8772e4l/p5J97Lhnw/+T/
2Azt4c5bA5D6f5n6P2GQ/2vwyv99PLCNQdn/dVwnof4Pj03xzzmPIvBf9M+579L8i5j/lRLY
/2uQ9f/HbtP+T2mdzn9x/leFkv/5HRDbGJT6z+qY/51zc/3PPZcM+M/8b9j/mbABRP/eS/R/
NSj5n2sAtjFo8e9S/Nvkn3suGfCf+ec+c6fUfyn/hy4Q5/9VKPnn7rlI8W+S/8f5L/q/dSn5
3/T8L53/a+vQ/9Vg6T/st1v2f8bI9P2PwvlfFZb+w377bbxdh+bMtw4o/rWc9n8VLvBfgYL/
bd//uxT/Ft9/VqHk/6NrWccgvf9N339JPdd/3HPJgP/M/185gGUMmv8Q/0po9ef9D+tcMuD/
+f3/VG9v9v8f4+O9NErj/z9VeOGf9bNbUv83+bfaKHz/CwAAAAAAAAAAcPEboUOr5wBQAAA=
--------------040105040101060204080409--
