Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWGaIlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWGaIlb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 04:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWGaIla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 04:41:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:63471 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750788AbWGaIla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 04:41:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=RBsv0RKSvUzMzmC28wwYfxOeQ8YBHWr22wMK8MDRWpf1OUnyIQ8MjL9v7u2xmQSD2EyBtOZTziIuqfDzEpUrCV3YIRX/Dv1oL+J9zDzVAD/+kfvjn6MIzPGDZ7ur4jdbFDxJetD0GG4+8pvnXC3T9mB1D+s15XpygSpVBOhfix0=
Message-ID: <215036450607310141j4649c048t25ae45f2b7ed75@mail.gmail.com>
Date: Mon, 31 Jul 2006 16:41:28 +0800
From: "Joe Jin" <lkmaillist@gmail.com>
To: kernel <linux@idccenter.cn>
Subject: Re: XFS Bug null pointer dereference in xfs_free_ag_extent
Cc: "Nathan Scott" <nathans@sgi.com>, jdi@l4x.org,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net,
       wim.coekaerts@oracle.com
In-Reply-To: <44CDB135.8080401@idccenter.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_17486_23303013.1154335288586"
References: <44BF29CD.1000809@l4x.org> <44CB0BF7.6030204@idccenter.cn>
	 <44CB1303.7010303@l4x.org>
	 <20060731094424.E2280998@wobbly.melbourne.sgi.com>
	 <44CDA156.6000105@idccenter.cn>
	 <20060731165522.K2280998@wobbly.melbourne.sgi.com>
	 <44CDB135.8080401@idccenter.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_17486_23303013.1154335288586
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

At XFS have a debug option, but I wonder why why it was not opened,
and you may open the option with follow patch, rebuild kernel, you
maybe get more information of it.
And when I trace the code, I also found at some function should check
the return value, it also include the patch.
Hope help for you.



On 7/31/06, kernel <linux@idccenter.cn> wrote:
> I format the same partition and restart the testing server before each
> testing.
> I'vs tested on each format at least twenty times.
> With XFS and SAN, This crash happens on every bonnie++ testing.
>
> And I have tested such things on another mathine, results are same.
>
>
> Nathan Scott wrote:
> > On Mon, Jul 31, 2006 at 02:21:10PM +0800, kernel wrote:
> >
> >> Test again......very strange.
> >> I can easily reproduce it on the XFS with SAN(FLX380) connected with a
> >> qlogic 2400 FC card.
> >>
> >
> > Eggshellent... can you reproduce it with each of those changes
> > (below) backed out of your tree please?  Else, git bisect is our
> > next best bet.  Thanks!
> >
> >
> >>> Is this easily reproducible for you?  I've not seen it before, and
> >>> the only possibly related recent changes I can think of are these:
> >>>
> >>> http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e63a3690013a475746ad2cea998ebb534d825704
> >>>
> >>> http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d210a28cd851082cec9b282443f8cc0e6fc09830
> >>>
> >>> Could you try reverting each of those to see if either is the cause?
> >>>
> >
> > cheers.
> >
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
Regards,
Joe.Jin

------=_Part_17486_23303013.1154335288586
Content-Type: text/x-patch; name=xfs.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqaldcgl
Content-Disposition: attachment; filename="xfs.patch"

LS0tIGxpbnV4LTIuNi4xOC1yYzMvZnMveGZzL0tjb25maWcJMjAwNi0wNy0zMCAxNDoxNTozNi4w
MDAwMDAwMDAgKzA4MDAKKysrIGxpbnV4Lm5ldy9mcy94ZnMvS2NvbmZpZwkyMDA2LTA3LTMxIDE2
OjIyOjMyLjAwMDAwMDAwMCArMDgwMApAQCAtMTcsNiArMTcsMTUgQEAKIAkgIHN5c3RlbSBvZiB5
b3VyIHJvb3QgcGFydGl0aW9uIGlzIGNvbXBpbGVkIGFzIGEgbW9kdWxlLCB5b3UnbGwgbmVlZAog
CSAgdG8gdXNlIGFuIGluaXRpYWwgcmFtZGlzayAoaW5pdHJkKSB0byBib290LgogCitjb25maWcg
WEZTX0RFQlVHCisJYm9vbCAiWEZTIGRlYnVnZ2luZyIKKwlkZXBlbmRzIG9uIFhGU19GUworCWhl
bHAKKwkgIElmIHlvdSBhcmUgZXhwZXJpZW5jaW5nIGFueSBwcm9ibGVtcyB3aXRoIHRoZSBYRlMg
ZmlsZXN5c3RlbSwgc2F5CisJICBZIGhlcmUuICBUaGlzIHdpbGwgcmVzdWx0IGluIGFkZGl0aW9u
YWwgZGVidWdnaW5nIG1lc3NhZ2VzIHRvIGJlCisJICB3cml0dGVuIHRvIHRoZSBzeXN0ZW0gbG9n
LiAgVW5kZXIgbm9ybWFsIGNpcmN1bXN0YW5jZXMsIHRoaXMKKwkgIHJlc3VsdHMgaW4gdmVyeSBs
aXR0bGUgb3ZlcmhlYWQuCisKIGNvbmZpZyBYRlNfUVVPVEEKIAlib29sICJYRlMgUXVvdGEgc3Vw
cG9ydCIKIAlkZXBlbmRzIG9uIFhGU19GUwotLS0gbGludXgtMi42LjE4LXJjMy9mcy94ZnMveGZz
X2J0cmVlLmMJMjAwNi0wNy0zMCAxNDoxNTozNi4wMDAwMDAwMDAgKzA4MDAKKysrIGxpbnV4Lm5l
dy9mcy94ZnMveGZzX2J0cmVlLmMJMjAwNi0wNy0zMSAxNTozOTo0My4wMDAwMDAwMDAgKzA4MDAK
QEAgLTU4Niw2ICs1ODYsOSBAQAogCSAqIEFsbG9jYXRlIGEgbmV3IGN1cnNvci4KIAkgKi8KIAlj
dXIgPSBrbWVtX3pvbmVfemFsbG9jKHhmc19idHJlZV9jdXJfem9uZSwgS01fU0xFRVApOworCWlm
KCFjdXIpCisJCXJldHVybiBOVUxMOworCiAJLyoKIAkgKiBEZWR1Y2UgdGhlIG51bWJlciBvZiBi
dHJlZSBsZXZlbHMgZnJvbSB0aGUgYXJndW1lbnRzLgogCSAqLwotLS0gbGludXgtMi42LjE4LXJj
My9mcy94ZnMveGZzX2FsbG9jLmMJMjAwNi0wNy0zMCAxNDoxNTozNi4wMDAwMDAwMDAgKzA4MDAK
KysrIGxpbnV4Lm5ldy9mcy94ZnMveGZzX2FsbG9jLmMJMjAwNi0wNy0zMSAxNjowOTowNC4wMDAw
MDAwMDAgKzA4MDAKQEAgLTY0OSw2ICs2NDksOSBAQAogCSAqLwogCWJub19jdXIgPSB4ZnNfYnRy
ZWVfaW5pdF9jdXJzb3IoYXJncy0+bXAsIGFyZ3MtPnRwLCBhcmdzLT5hZ2JwLAogCQlhcmdzLT5h
Z25vLCBYRlNfQlROVU1fQk5PLCBOVUxMLCAwKTsKKwlpZighYm5vX2N1cikKKwkJcmV0dXJuIFhG
U19FUlJPUihFTk9NRU0pOworCQogCS8qCiAJICogTG9va3VwIGJubyBhbmQgbWlubGVuIGluIHRo
ZSBidHJlZSAobWlubGVuIGlzIGlycmVsZXZhbnQsIHJlYWxseSkuCiAJICogTG9vayBmb3IgdGhl
IGNsb3Nlc3QgZnJlZSBibG9jayA8PSBibm8sIGl0IG11c3QgY29udGFpbiBibm8K
------=_Part_17486_23303013.1154335288586--
