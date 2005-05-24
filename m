Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVEXM11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVEXM11 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 08:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVEXM10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 08:27:26 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:7835 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262027AbVEXM0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 08:26:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=GQRzlMLVZmKDveQmUQGmYtkGekziftCoNGQPSB3EBd1+Acle8QDTjJMReQ/cWA3PCoK0LE2TPcn6xrTBritoCRzM8srVShSJLJzPi+gtS9X5Kgcsz2eS0/5xSzunk/7TNghGrOUYYOH4GEPH/TyGyVTLeVF48UPUHaBsq/8g1Ww=
Message-ID: <42931E38.6030403@gmail.com>
Date: Tue, 24 May 2005 14:29:44 +0200
From: Mateusz Berezecki <mateuszb@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: __udivdi3 and linux kernel u64 division question [x86]
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list members,

After a failure of compilation of the similar code snippet


u64 mconst = somebig64bitvalue;
u64 tmp = some32bitvalue;
u64 r = mconst / tmp;

I encounter compilation error and gcc reporting __udivdi3 has not been
found!
After firing up cscope I found that this function has never(?) been
implemented for
x86 architecture. How is it possible that during compilation process of
some module
make system tries to link with nonexisting function?

I've also found a do_div() and it was sufficent for my purposes but Im
still curious about
__udivdi3. Can someone explain this issue to me?
