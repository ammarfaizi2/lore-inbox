Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135578AbRDXMyh>; Tue, 24 Apr 2001 08:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135583AbRDXMy2>; Tue, 24 Apr 2001 08:54:28 -0400
Received: from t2.redhat.com ([199.183.24.243]:2803 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135578AbRDXMyO>; Tue, 24 Apr 2001 08:54:14 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.GSO.4.21.0104240639580.6992-100000@weyl.math.psu.edu> 
In-Reply-To: <Pine.GSO.4.21.0104240639580.6992-100000@weyl.math.psu.edu> 
To: Alexander Viro <viro@math.psu.edu>
Cc: Christoph Rohland <cr@sap.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Apr 2001 13:51:32 +0100
Message-ID: <21657.988116692@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


viro@math.psu.edu said:
>  What I would like to avoid is scenario like
> Maintainers of filesystems with large private inodes: Why would we
> separate them? We would only waste memory, since the other filesystems
> stay in ->u and keep it large.

> Maintainers of the rest of filesystems: Since there's no patches that
> would take large stuff out of ->u, why would we bother?

> So yes, IMO having such patches available _is_ a good thing. And in
> 2.5 we definitely want them in the tree. If encapsulation part gets
> there during 2.4 and separate allocation is available for all of them
> it will be easier to do without PITA in process.

JFFS2 has the encapsulation part already. I'll make it do separate 
allocation in 2.5, when it's actually a gain.

--
dwmw2


