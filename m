Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317305AbSHHCvy>; Wed, 7 Aug 2002 22:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317312AbSHHCvy>; Wed, 7 Aug 2002 22:51:54 -0400
Received: from pop015pub.verizon.net ([206.46.170.172]:31641 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S317305AbSHHCvx>; Wed, 7 Aug 2002 22:51:53 -0400
Message-ID: <3D51DD80.6070501@verizon.net>
Date: Wed, 07 Aug 2002 22:54:56 -0400
From: "Anthony Russo., a.k.a. Stupendous Man" <anthony.russo@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 BUG in page_alloc.c:91
References: <Pine.LNX.4.44L.0208072350060.23404-100000@imladris.surriel.com>
X-Enigmail-Version: 0.62.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I don't believe I have any "proprietary" modules loaded, but
here is the output of lsmod:


Module                  Size  Used by    Tainted: P 
nls_iso8859-1           3488   1 (autoclean)
nls_cp437               5120   1 (autoclean)
vfat                   11804   1 (autoclean)
fat                    36024   0 (autoclean) [vfat]
smbfs                  36960   1 (autoclean)
ppp_async               7840   0 (unused)
sb                      8992   1 (autoclean)
apm                    11976   2
ppa                    10688   0 (unused)
rtc                     7484   0 (unused)
ppp_synctty             6176   1
ppp_generic            19212   3 [ppp_async ppp_synctty]
slhc                    6028   0 [ppp_generic]
n_hdlc                  7168   1
sb_lib                 39456   0 [sb]
uart401                 7744   0 [sb_lib]
sound                  69292   1 [sb_lib uart401]
soundcore               6276   5 [sb_lib sound]
isa-pnp                36892   0 [sb]
nfsd                   74496   8 (autoclean)
lockd                  54976   1 (autoclean) [nfsd]
sunrpc                 72628   1 (autoclean) [nfsd lockd]
parport_pc             17444   2 (autoclean)
lp                      7872   0 (autoclean)
ipt_ttl                 1152   1 (autoclean)
ipt_limit               1568  35 (autoclean)
ipt_unclean             7520   3 (autoclean)
ip_nat_irc              3680   0 (unused)
ip_nat_ftp              4448   0 (unused)
ipt_state               1088   7 (autoclean)
iptable_mangle          2688   0 (unused)
ipt_LOG                 4160   1
ipt_MASQUERADE          2560   1
ipt_TOS                 1568   0 (unused)
ipt_REDIRECT            1280   0 (unused)
iptable_nat            23860   3 [ip_nat_irc ip_nat_ftp ipt_MASQUERADE
ipt_REDIRECT]
ipt_REJECT              3488   0 (unused)
ip_conntrack_irc        3552   0 [ip_nat_irc]
ip_conntrack_ftp        4832   0 [ip_nat_ftp]
ip_conntrack           26636   4 [ip_nat_irc ip_nat_ftp ipt_state
ipt_MASQUERADE ipt_REDIRECT iptable_nat ip_conntrack_irc ip_conntrack_ftp]
iptable_filter          2368   1 (autoclean)
ip_tables              15808  14 [ipt_ttl ipt_limit ipt_unclean
ipt_state iptable_mangle ipt_LOG ipt_MASQUERADE ipt_TOS ipt_REDIRECT
iptable_nat ipt_REJECT iptable_filter]
fa312                   5900   1
usb-uhci               24260   0 (unused)
usbcore                77344   1 [usb-uhci]


Rik van Riel wrote:

>On Wed, 7 Aug 2002, Anthony Russo., a.k.a. Stupendous Man wrote:
>
>  
>
>> My info: Pentium III PC, kernel 2.4.19 vanilla, redhat 7.3, reiserfs.
>>
>>It's not pretty. Let me know what I can do to help.
>>
>>Aug  7 19:23:30 manic kernel:  kernel BUG at page_alloc.c:89!
>>    
>>
>
>  
>
>>Aug  7 19:23:30 manic kernel: EIP:    0010:[<c012c331>]    Tainted: P
>>    
>>
>
>Which proprietary module have you loaded ?
>
>kind regards,
>
>Rik
>  
>

-- tony


