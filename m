Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S135248AbRDXKV3>; Tue, 24 Apr 2001 06:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S135258AbRDXKVT>; Tue, 24 Apr 2001 06:21:19 -0400
Received: from t2.redhat.com ([199.183.24.243]:10991 "EHLO passion.cambridge.redhat.com") by vger.kernel.org with ESMTP id <S135248AbRDXKVA>; Tue, 24 Apr 2001 06:21:00 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.GSO.4.21.0104240601410.6992-100000@weyl.math.psu.edu> 
References: <Pine.GSO.4.21.0104240601410.6992-100000@weyl.math.psu.edu> 
To: Alexander Viro <viro@math.psu.edu>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>, Christoph Rohland <cr@sap.com>, "David L. Parsley" <parsley@linuxjedi.org>, linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Apr 2001 11:19:50 +0100
Message-ID: <30885.988107590@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


viro@math.psu.edu said:
>  <tone polite> What's stopping you? </tone> You _are_ JFFS maintainer,
> aren't you?

It already uses...

#define JFFS2_INODE_INFO(i) (&i->u.jffs2_i) 

It's trivial to switch over when the size of the inode union goes below the 
size of struct jffs2_inode_info. Until then, I'd just be wasting space.

--
dwmw2


