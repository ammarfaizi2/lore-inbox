Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWJBJVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWJBJVu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 05:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWJBJVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 05:21:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:43584 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750985AbWJBJVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 05:21:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ghvJw956LLr9r13pDaorSdMOn3KRwCa051qNrZG7YR6qOvpJlaQM29eIXRcCxMmc/VqjGihTdh059vZewxsh0ISNNmQ7L6+Zcf53LlJ5BZ2w8B6UG1sMvDXIFhX5CrZblS00zTxQlppK/nAZ2UjHfV4O0sAKlbtk1NX3d1FxyTU=
Message-ID: <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com>
Date: Mon, 2 Oct 2006 09:21:48 +0000
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Norbert Preining" <preining@logic.at>
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Cc: hostap@shmoo.com, ipw3945-devel@lists.sourceforge.net,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/06, Norbert Preining <preining@logic.at> wrote:
> Dear all!
>
> I have the following problem with wpa supplicant/ipw3945. First the
> versions:
> kernel: 2.6.18-mm2      (self compiled)
> ieee80211:      1.1.14
> ipw3945:        git source
> ipw3945d:       1.7.19
> wpa supplicant: 0.5.5   (Debian/unstable 0.5.5-1)
>
>
> Config file of wpa_supplicant:
> ctrl_interface=/var/run/wpa_supplicant
> ctrl_interface_group=0
> eapol_version=1
> ap_scan=1
> network={
>         ssid="norbunet"
>         key_mgmt=NONE
>         auth_alg=SHARED
>         wep_key0=HEXKEY1
>         wep_key1=HEXKEY2
>         wep_key2=HEXKEY3
>         wep_key3=HEXKEY4
>         wep_tx_keyidx=0
>         priority=5
> }
>
> When I start ipw3945d and wpa_supplicant it does not connect. And the
> reason is that when typing
>         iwconfig eth2
> (eth0 cable, eth1 not present!?!, eth2 ipw3945) I see that the ESSID is
> set to
>         "norbune"
> instead of
>         "norbunet"
>
> Calling
>         iwconfig eth2 essid "norbunet "
> (mind the space at the end) immediately connects (even with encryption)
> and everything is working.
>
> Do you have any idea what this might be related to?
>
> The last kernel I tried which worked out of the box (well, with
> comnpiling ieee and ipw) was 2.6.18-rc4.

Hi Norbert,

  we've been just through an email thread where it has been
  determined that wpa_supplicant 0.4.9 (I would assume that
  0.5.5 is also okay) and wireless-tools from Jean's latest
  tarball are necessary to work with the recent wireless
  extensions v21 that have been merged in.

What wireless-tools are you using ?

Ciao,

--alessandro

"Well a man has two reasons for things that he does
  the first one is pride and the second one is love
  all understandings must come by this way"

     (Husker Du, 'She Floated Away')
