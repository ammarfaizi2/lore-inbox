Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSILTfk>; Thu, 12 Sep 2002 15:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSILTfk>; Thu, 12 Sep 2002 15:35:40 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:8183 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317112AbSILTfj>; Thu, 12 Sep 2002 15:35:39 -0400
Date: Thu, 12 Sep 2002 15:40:29 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Linux Aio <linux-aio@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 port of aio-20020619 for raw devices
Message-ID: <20020912154029.B20206@redhat.com>
References: <3D80DB14.2040809@watson.ibm.com> <20020912143540.J18217@redhat.com> <3D80DEF4.1080906@watson.ibm.com> <20020912145324.L18217@redhat.com> <3D80EB90.3020304@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D80EB90.3020304@watson.ibm.com>; from nagar@watson.ibm.com on Thu, Sep 12, 2002 at 03:31:28PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 03:31:28PM -0400, Shailabh Nagar wrote:
> I see. So generic_aio_rw would directly call some function which used 
> dio's rather than map the kvec first and call a kvec_op  ?

There should be no generic_aio_rw.  Don't bring it back.  Don't make any 
kvec ops either for it, just implement aio_read.

		-ben
