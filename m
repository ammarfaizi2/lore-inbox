Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271270AbTHHG6d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 02:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271272AbTHHG6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 02:58:33 -0400
Received: from sun1000.pwr.wroc.pl ([156.17.1.33]:5259 "EHLO
	sun1000.pwr.wroc.pl") by vger.kernel.org with ESMTP id S271270AbTHHG63
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 02:58:29 -0400
Date: Fri, 8 Aug 2003 08:58:27 +0200
From: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre10-ac1 -- lots of unresolved symbols
Message-ID: <20030808065827.GA14918@pwr.wroc.pl>
Reply-To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
References: <20030807133053.GA18191@pwr.wroc.pl> <20030807140232.GC7094@louise.pinerecords.com> <20030807194953.GA15747@pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807194953.GA15747@pwr.wroc.pl>
X-Useless-Header: Vim powered ;^)
X-00-Privacy-Policy: OpenPGP or S/MIME encrypted e-mail is welcome.
X-01-Privacy-Policy-GPG-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?search=dzieko@pwr.wroc.pl&op=get
X-02-Privacy-Policy-GPG-Key_ID: 5AA7253D
X-03-Privacy-Policy-GPG-Key_fingerprint: A80B 5022 185B 1BB5 8848  74C4 A7E1 423C 5AA7 253D
X-04-Privacy-Policy-Personal_SSL_Certificate: http://www.europki.pl/cgi-bin/dn-cert.pl?serial=00000069&certdir=/usr/local/cafe/data/polish_ca/certs_31.12.2002/user&type=email
X-05-Privacy-Policy-CA_SSL_Certificate: http://www.europki.pl/polish_ca/ca_cert/en_index.html
User-Agent: Mutt/1.5.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

now i have just used defconfig after mrproper and this:

cd /lib/modules/2.4.22-pre10-ac1; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map
2.4.22-pre10-ac1; fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.22-pre10-ac1/kernel/drivers/n
et/dummy.o
depmod:         register_netdev_Rsmp_f8a1d0ee
depmod:         __kfree_skb_Rsmp_f5f3cd6e
depmod:         kfree_Rsmp_037a0cba
depmod:         dev_alloc_name_Rsmp_44746846
depmod:         kmalloc_Rsmp_93d4cfe6
depmod:         ether_setup_Rsmp_d95733a5
depmod:         unregister_netdev_Rsmp_b48d7ea9
make: *** [_modinst_post] Bd 1

any idea? P
-- 
Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
Wroclaw Networking & Supercomputing Center, HPC Department
-> See message headers for privacy policy info.
