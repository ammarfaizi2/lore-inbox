Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVGMJw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVGMJw3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 05:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVGMJw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 05:52:28 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:62080 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S262409AbVGMJw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 05:52:27 -0400
Message-ID: <42D4E452.9090407@gwdg.de>
Date: Wed, 13 Jul 2005 11:52:18 +0200
From: Christian Boehme <Christian.Boehme@gwdg.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at objrmap:325 in 2.6.5-7.151-smp (SuSE, x86_64)
References: <4pLpN-1F0-15@gated-at.bofh.it> <4pLzx-1KX-23@gated-at.bofh.it>
In-Reply-To: <4pLzx-1KX-23@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
X-AUTH-Id: cboehme1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven schrieb:
> you really should call SuSE support for this... after all that's what
> you're paying them for ;)

We use SLES because it is a requiremnet for getting support for some
vendor-supplied MPI-libraries... but you are of course still right. I
file a bug report to them as well.

>>kernel: Kernel BUG at objrmap:325
>>kernel: invalid operand: 0000 [1] SMP
>>kernel: CPU 0
>>kernel: Pid: 4752, comm: mhd3d.opteron Tainted: G  U (2.6.5-7.151-smp SLES9_SP1_BRANCH-200503181131210000)
> 
> 
> which modules do you use ?

Here's the list:

joydev                 19584  0
sg                     51000  0
st                     51236  0
sr_mod                 26788  0
thermal                22668  0
processor              28352  1 thermal
fan                    12808  0
button                 15648  0
battery                17928  0
ac                     13832  0
ipv6                  317304  21
tg3                    88324  0
ohci_hcd               29700  0
evdev                  18944  0
usbcore               131824  3 ohci_hcd
ib_sdp                136000  0
ib_useraccess_cm       28320  0
ib_cm                  59000  2 ib_sdp,ib_useraccess_cm
ib_udapl               49852  0
ib_ip2pr               38200  3 ib_sdp,ib_useraccess_cm,ib_udapl
ib_ipoib               75160  2 ib_udapl,ib_ip2pr
ib_useraccess          21540  0
ib_sa_client           41232  3 ib_udapl,ib_ip2pr,ib_ipoib
ib_client_query        27040  4 ib_udapl,ib_ip2pr,ib_ipoib,ib_sa_client
ib_tavor               40964  7 ib_useraccess_cm
mod_vapi              169824  3 ib_useraccess_cm,ib_udapl,ib_tavor
mod_vipkl             262520  1 mod_vapi
mod_thh               258272  1 mod_vapi
mod_hh                 31888  2 mod_vipkl,mod_thh
mod_mpga               35200  1 mod_vapi
mod_vapi_common       103296  6 ib_useraccess_cm,ib_udapl,ib_tavor,mod_vapi,mod_vipkl,mod_thh
mosal                 155340  5 mod_vapi,mod_vipkl,mod_thh,mod_mpga,mod_vapi_common
ib_mad                 34200  4 ib_cm,ib_useraccess,ib_client_query,ib_tavor
ib_core               286744  10 ib_sdp,ib_useraccess_cm,ib_cm,ib_udapl,ib_ip2pr,ib_ipoib,ib_useraccess,ib_sa_client,ib_tavor,ib_mad
ib_poll                34768  4 ib_sdp,ib_cm,ib_ip2pr,ib_client_query
ib_services            28484  13 ib_sdp,ib_useraccess_cm,ib_cm,ib_udapl,ib_ip2pr,ib_ipoib,ib_useraccess,ib_sa_client,ib_client_query,ib_tavor,ib_mad,ib_core,ib_poll
mst_pciconf            95488  0
mst_pci                93312  2
w83627hf               39172  0
lm85                   34052  0
i2c_sensor             11520  2 w83627hf,lm85
i2c_isa                11008  0
i2c_amd756             15620  0
i2c_core               35716  5 w83627hf,lm85,i2c_sensor,i2c_isa,i2c_amd756
dm_mod                 67776  0
ext3                  133104  3
jbd                    83144  1 ext3
sata_sil               17284  4
libata                 51200  1 sata_sil,[permanent]
sd_mod                 29568  5
scsi_mod              140800  5 sg,st,sr_mod,libata,sd_mod

The ib_* modules are for the Infiniband network connections. Thanks for
your help!

Best wishes

Christian Boehme

-- 
Dr. Christian Boehme
GWDG                            Private:
Am Fassberg                     Wilhelm-Raabe-Str. 15
37077 Göttingen                 37083 Göttingen
email: Christian.Boehme@gwdg.de ChristianBoehme@web.de
phone: +49 (0)551 201-1839      +49 (0)551 3077000
fax:   +49 (0)551 201-2150      +49 (0)551 3077077

