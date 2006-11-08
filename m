Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754596AbWKHRON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596AbWKHRON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754597AbWKHRON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:14:13 -0500
Received: from cernmx06.cern.ch ([137.138.166.160]:16407 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S1754596AbWKHROL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:14:11 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding;
	b=cDauOx8DhRLrnuQoIYqt8DUREvTVILZ/6SVa5M9f3DGloLceyy9LPP/jwIXHO5NQiQVPajxSV+M4N2aUsDzK9KTE2w26LegOFFA8IjBRDktQ9rK2X8EFsun4w7u7IjvW;
Keywords: CERN SpamKiller Note: -51 Charset: west-latin
X-Filter: CERNMX06 CERN MX v2.0 060921.0942 Release
From: Martin Weber <Martin.Weber@cern.ch>
Organization: RWTH Aachen
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: kernel BUG at include/linux/dcache.h:303
Date: Wed, 8 Nov 2006 18:14:06 +0100
User-Agent: KMail/1.9.1
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org
References: <200611081708.43932.Martin.Weber@cern.ch> <E1GhqOq-0001MA-00@dorka.pomaz.szeredi.hu> <20061108170709.GA30221@infradead.org>
In-Reply-To: <20061108170709.GA30221@infradead.org>
X-Face: ULps1'$vijmn.0n2esJBV6~3TZEWaOGi6}g13GH{7g2[3qU+`tG}@=?utf-8?q?N4i=27=5DB8Ba=7Ev*CC=2EnF=0A=09?=<O/g;0:;ovG7kSc~M$/[jneF|?o4VqVpQ}.Fg^:_`^Hy_FM?B)^Gp%*t%vhzyW=z3(=?utf-8?q?=5Ea=7Ef=0A=09+Zo9=7Dj8O=5DPk=2E=5BC-=5F!=3B4W=24B=5F=7DPK=5Fvx?=
 =?utf-8?q?R=5Dy0Anf?=("
 =?utf-8?q?m!L=26FLj!F=7CzvV=5Ft/n=267AmgU8d=5C=7DDZFJ9=0A=098=7BQ=26AE?=@AdRYX:bu*G#T#s%CEcwl0P@qeVEj;o2J5q]Z9w2j*>uaN9@gkj\(Q":0oB>@
 =?utf-8?q?!=24F=0A=09SK?=<QP"0<~&Z(/HCiXeFc5w=jC<rW+4T-_;w*@[p`VP3@u:e5pbK^VD;"Uar:BI`W2g
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611081814.06652.Martin.Weber@cern.ch>
X-OriginalArrivalTime: 08 Nov 2006 17:14:08.0674 (UTC) FILETIME=[4D45C820:01C70359]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 08 November 2006 18:07, Christoph Hellwig wrote:
> On Wed, Nov 08, 2006 at 05:35:40PM +0100, Miklos Szeredi wrote:
> > > Whatever propritary module shfs is it's most likely the cause.
> > > Please try again without it.
> >
> > While not propritary, shfs _is_ severely broken.  Try sshfs instead
> > which provides similar functionality:
> >
> >   http://fuse.sourceforge.net/sshfs.html
>
> Agreed to that recommendation.  But then again either shfs is so outdated
> that it doesn't even have a MODULE_LICENSE state or the submitter snipped
> away a module without a proper license from the oops report..

SHFS seems to be outdated. Checking on the web reveals the last release and 
web page update was 2.5 years ago. The source contains a license statement:
shfs/Linux-2.6/inode.c:MODULE_LICENSE("GPL");

I have one tainted module (cisco_ipsec) loaded, which was not in the post 
since I did not know of the importance.

M.

-- 
Martin Weber           Office: +49-241-80-27183
I. Physik. Inst. B        Fax: +49-241-80-22661
RWTH Aachen
D-52056 Aachen           http://home.cern.ch/Martin.Weber
