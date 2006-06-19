Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWFSRwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWFSRwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWFSRwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:52:25 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:10127 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751267AbWFSRwY (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:52:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IonH0UGPtxb/ldLvnjoZqv8RxMJpVomVXqqKueGVoZgHvvSkHnz6Is3P6qpznq+2B4Pv95RtS4mZqB/3kg2mRhjdP4TPV3WwpdFAU7jqUM19Kku36b+eUC91fqggHoPYrHSRe/rBBncicnS0vTqC8vYUAUbXxNVhEbk7I3cJeXw=
Message-ID: <e48344780606191052u43db7e45wd175e7f818c4a192@mail.gmail.com>
Date: Mon, 19 Jun 2006 13:52:23 -0400
From: "Akshat Aranya" <aaranya@gmail.com>
To: "Miklos Szeredi" <miklos@szeredi.hu>
Subject: Re: batched write
Cc: reiser@namesys.com, nix@esperi.org.uk, akpm@osdl.org, vs@namesys.com,
       hch@infradead.org, Reiserfs-Dev@namesys.com,
       Linux-Kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       drepper@redhat.com
In-Reply-To: <E1FsNeQ-0004pV-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44736D3E.8090808@namesys.com>
	 <20060608121006.GA8474@infradead.org>
	 <1150322912.6322.129.camel@tribesman.namesys.com>
	 <20060617100458.0be18073.akpm@osdl.org> <4494411B.4010706@namesys.com>
	 <87ac8an21r.fsf@hades.wkstn.nix> <449668D1.1050200@namesys.com>
	 <E1FsHzf-0004ES-00@dorka.pomaz.szeredi.hu>
	 <4496D34F.4010007@namesys.com>
	 <E1FsNeQ-0004pV-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/06, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > I would think that batched write is pretty essential then to FUSE
> > performance.
>
> Well, yes essential if the this is the bottleneck in write throughput,
> which is most often not the case, but sometimes it is.
>

I can vouch for this.  I did some experiments with an example FUSE
filesystem that discards the data in userspace.  Exporting such a
filesystem over NFS gives us 80 MB/s writes when FUSE is modified to
write with 32K block sizes.  With the standard FUSE (4K writes), we
get  closer to 50 MB/s.

> Miklos


-Akshat
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
